const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const firestore = admin.firestore();
// const messaging = admin.messaging();

console.log("Cloud function initialized");

exports.sendRemindersNotifications = functions.pubsub
    .schedule("every 1 minutes").onRun(async (context) => {
      const now = new Date();
      const currentYear = now.getFullYear();
      const currentMonth = now.getMonth();
      const currentDay = now.getDate();
      const currentHour = now.getHours();
      const currentMinute = now.getMinutes();

      const reminderCollection = firestore.collection("reminders");

      const reminderSnapshot = await reminderCollection.get();

      reminderSnapshot.forEach(async (reminderDoc) => {
        const reminderData = reminderDoc.data();
        const reminderDate = reminderData.reminderDate.toDate();
        const reminderYear = reminderDate.getFullYear();
        const reminderMonth = reminderDate.getMonth();
        const reminderDay = reminderDate.getDate();
        const reminderHour = reminderDate.getHours();
        const reminderMinute = reminderDate.getMinutes();

        if (currentYear === reminderYear &&
            currentMonth === reminderMonth &&
            currentDay === reminderDay &&
            currentHour === reminderHour &&
            currentMinute === reminderMinute) {
          const title = reminderData.reminderTitle;
          const body = reminderData.reminderDescription;
          const userID = reminderData.userID;

          const userDoc = await firestore.collection("users").doc(userID).get();

          if (userDoc.exists) {
            const token = userDoc.data().token;

            const message = {
              notification: {
                title: title,
                body: body,
              },
              data: {
                reminderID: reminderDoc.id,
              },
              token: token,
            };

            if (token) {
              try {
                await admin.messaging().send(message);
                console.log("Notification sent successfully" + userID);
              } catch (error) {
                console.log("Error sending notification \n"+ error);
              }
            }
          }
        }
      });
      return null;
    });