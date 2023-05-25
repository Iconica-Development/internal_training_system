const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduledFunction = functions.pubsub
    .schedule('0 10 * * *')
    .timeZone('Etc/UTC')
    .onRun(async (context) => {
        console.log('Check once a day if training notifications have to be send.');
        log("Hello logs!");
        // Perform the desired operations
        // For example, you can access Firestore and update documents
        const firestore = admin.firestore();
        // const collectionRef = firestore.collection('your_collection');
        const documents = await collectionRef.get();
        documents.forEach((doc) => {
            // Update or perform operations on each document
        });

        return null;
    });