import express from 'express';
import { initializeApp } from "firebase/app";
//import { getAnalytics } from "firebase/analytics";
const app = express();
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';



//firebasefi
//import { getAuth } from "firebase/auth";
//import { initializeApp } from 'firebase-admin/app';
//const auth = getAuth();
//firebase

const firebaseConfig = {
  apiKey: "AIzaSyCj4fG1yaJOHYXPUDsfNoGUxBlXitOGUKg",
  authDomain: "learningmate-fe6a1.firebaseapp.com",
  databaseURL: "https://learningmate-fe6a1-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "learningmate-fe6a1",
  storageBucket: "learningmate-fe6a1.appspot.com",
  messagingSenderId: "215167370497",
  appId: "1:215167370497:web:cc950598d5e48866940700",
  measurementId: "G-13CYRYX878"
};
const firebaseapp = initializeApp(firebaseConfig);

// Initialize Firebase
//const analytics = getAnalytics(app);

//port
const PORT = 5000;
//admin SDK
import admin from "firebase-admin";
import serviceAccount from "./serviceAccountKey.json" assert {type: 'json'};
import ejs from "ejs";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://learningmate-fe6a1-default-rtdb.asia-southeast1.firebasedatabase.app"
});


app.set('view engine', 'ejs');  
app.engine("html",ejs.renderFile);
// style 적용 
app.use(express.static("static"));


app.use(bodyParser.json());
app.use(cookieParser());


//session login
app.post("/sessionLogin", (req, res) => {
  const idToken = req.body.idToken.toString;
  const expiresin = 60 * 60 * 24 * 5 * 1000;
  admin
  .auth()
  .createSessionCookie(idToken,{expiresin})
  .then(

      (sessionCookie) => {
        const options = {maxAge: expiresin, httpOnly: true};
        //res.cookie("session", sessionCookie,options);
        res.end(JSON.stringify({status:"success"}));
      },
      //error
      (error) => {
      res.status(401).send("UNAUTHORIZED Request");
      res.redirect("/login");
      }
  )
});

//첫 주소
app.get("/",function(req, res) {
  console.log('/index');
  res.render("index.html");
});

// 프로필 상태
app.get("/status", function (req, res) {
  console.log('status');
  res.render("status.html");
});

// 회원가입
app.get("/signup", function (req, res){
  console.log('signup');
  res.render("signup.html");
});

//로그인 
app.get("/login", function (req, res) {
  res.render("login.html");
});

// 프로필 
app.get("/profile", function (req, res){
  const sessionCookie = req.cookie.session || "";
  admin.auth().verifySessionCookie(sessionCookie,true)
  .then( () => {
        res.render("profile.html");
  })
  .catch((error) => {
    res.redirect("/login");
  });
});

//logout 
app.get("/sessionLogout",(req, res) => {
      res.clearCookie("session");
      res.redirect("/login");
});


//The app only has access as defined in the Security Rules
var db = admin.database();
var ref = db.ref("/some_resource");
ref.once("value", function(snapshot) {
  console.log(snapshot.val());
});

app.listen(PORT, () => {
  console.log(`Listening on http://localhost:${PORT}`);
} );


