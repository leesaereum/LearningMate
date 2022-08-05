import { getAuth, sendPasswordResetEmail } from "firebase/auth";
const express = require("express");
const app = express();
const bodyParser = require('body-parser');
const cors = require("cors")

//admin SDK
var admin = require("firebase-admin");
var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://learningmate-fe6a1-default-rtdb.asia-southeast1.firebasedatabase.app"
});


app.use(cors());
var jsonParser = bodyParser.json()

app.get("/status", (req, res) => {
    res.send("check Status");
});

// The app only has access as defined in the Security Rules
var db = admin.database();
//주소창 
var ref = db.ref("/some_resource");
ref.once("value", function(snapshot) {
  console.log(snapshot.val());
});

  //비밀번호 재설정 이메일 보내기 
const auth = getAuth();
sendPasswordResetEmail(auth, email)
    .then(() => {
      // Password reset email sent!
      // ..
    })
    .catch((error) => {
      const errorCode = error.code;
      const errorMessage = error.message;
      // ..
    });



