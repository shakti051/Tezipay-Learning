import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "fir-example-33c88",
        "private_key_id": "42899c5ec5844f7b53624b74d08ef84a3ab24094",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrOWvN/EFmurTj\nPzlYgPRrVq9G4SWb+nDBUpgVNcEwxCnFmUMonoi65TX7XslguCYa+2w0/JhnWc7a\nzWVdey7aipuqKUL28mEGdwig7DjymZ+ybj/Yw8ddeRMWJp41zPKrmOTH/OrMrihA\n6xrl1aZfe2u3oTJzYhLia9JxWBCLIJF6FmKruCgvQSQMOxuqGD4CHl/XpPTSlgSC\nrFY3fWSp8aE0EuNS6uvQIGvkmv+OWEffJTczgZ1wq/inDQWB1cKdWUEKoyyqjl/2\nxLUGeJZsbq/wV4gZTM8pS+c2v1WfYaF8yoCWX+qxDJMsxnHFfHF16Co4WyqbFpNB\nvb0EdPafAgMBAAECggEAB+CJZB2RyK8YOUgkVD0CgZmoUKN0/nsECvDIzFj/vUWZ\nAl0tqMW6VpbK5/iRXSC7qAwfC0T/oemQyaIfYrCTFDzCMo7ZZND7w7dgLz8O06Jb\npXLK/ybqmhNC3IcESkdWdqx/AfBRwP7WHT5zq1Ur5UKhTv5cetBtO/tn4A0EHdJb\necySJFz0AwS1KgH8HTv1zImSop4Kj210DxGXlsLzt0CDKWzNNcDRYE/Hx0Sd+aKz\ndYUFt4UC0m/txcNafF1XBfZUa51O8MLNxrAO47UPYYv2OpcdG1AhuRaETKrygJn/\noCo94pYwoHrUY+6ruhhamIYazW5jyHDe1gEZFetXgQKBgQDW37gSnPGePxnAN6VG\n5vr76y3Bo/uyTUrxDAlX0yrSV0d6iPfBNxgCsr+UnP7Sw9UV+U2YOSvQ+xISF+Pj\n8jYtHK6xvUbnKQPdPhpO8TPWcAfMK7BOdqcqKcNHKXeAYPZNlAU/I4ajGCGcQG0g\nzzAbsyccJSKve8529QcqD9nsXwKBgQDL/vs6qpM42kVuo1NWUHsqGmO9WODx5wWq\nDBsVdQDvBqbjrkAvOPH56mtyZ2rSgvY9AIwzsSq4jXtQzmgye1hQBYS+LTP6RVzI\nureuMMiFWOxiqPGhhwgM/iegYDctKaiykZSZQkZI0GjPdfsYr/yhw7arHF/cRbCc\nGRggaX0dwQKBgQCYRI2C0yj9xSWQa156MjDl2LDiKjyxC8jxrF/qlsAfsq36jZlU\nmKAxOU4+GEsUPKaCHdr45nrAa0tQ+xEJdZkiutKpLcJTCWOtotat3ouniFhePQ+B\nat/nJxU1FpOSrCOesihNp/U/GlinC5jJyUkEOB6c+UvtI0UaU2UyT21U7QKBgGCh\nU9giXMKdgi46Z4uHbBAxl/VlWIi96kz2lw2+8sZG3F8Vd4nm65h6lpMGse8t4f5b\neA40agwp2LQaUfk3vEmLk6mSOADhQmZDLCbzLMkdqjvB01O0ZvfgnFy3tutJxINx\nunYukqSDNGKxfFPhaUYnMywysKXizRnkOS2BSqcBAoGAOWFffwCeVW/ESznFp3Oo\nQRZjMQmNzmc8H78AOhjH0samhyfEn+bq3MxnxR91AMZE1VXk8Nw8J3KqQg7nadal\nLTj75Zg2INzqWSNyb2KteoO8w60ugwI/S9t/V4qyIgtchOun7+dbj4WNGrer6ZOl\nk6hQNVcrXQbSeNPre1/svL4=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-odi2u@fir-example-33c88.iam.gserviceaccount.com",
        "client_id": "108605737953170126460",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-odi2u%40fir-example-33c88.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
