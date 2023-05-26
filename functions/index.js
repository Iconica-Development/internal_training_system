/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.dailyNotificationForUpcomingTrainings = functions.pubsub.schedule('every 5 minutes').onRun(async (context) => {
    const today = new Date();
    const oneWeekFromToday = new Date();
    oneWeekFromToday.setDate(today.getDate() + 7);
    oneWeekFromToday.setHours(0, 0, 0, 0);

    console.log("BEGIN VAN SCHEDULE FUNCTION");
    console.log('One week from today: ' + oneWeekFromToday);

    const trainingsSnapshot = await admin.firestore().collection("training_planning")
        .where("startDate", ">=", oneWeekFromToday)
        .where("startDate", "<", new Date(oneWeekFromToday.getTime() + 24 * 60 * 60 * 1000))
        .get();

    const trainings = trainingsSnapshot.docs.map((doc) => doc.data());

    for (const training of trainings) {
        console.log("TRAINING GEVONDEN");
        await admin.firestore().collection("mails").add({
            to: ["vlusionwebbuilding@gmail.com"],
            template: {
                name: "upcoming_training",
                data: {
                    name: "Vick",
                    training: training.trainingName,
                },
            },
        });
    }
});