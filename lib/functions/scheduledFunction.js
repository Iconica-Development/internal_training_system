const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const database = admin.firestore();

exports.timerUpdate = functions.pubsub.schedule('every 5 minutes').onRun((context) => {
    database.doc("NOTIFICATIONS/91xoK9Y5Jz69Nqlhm2Ky").update({ "time": admin.firestore.Timestamp.now() });
    return console.log('successful timer update');
});