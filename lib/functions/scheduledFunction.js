const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.createFunctionLog = functions.pubsub.schedule('6 10 * * *').timeZone('Etc/UTC').onRun(async (context) => {
    try {
        const db = admin.firestore();
        const functionLogsRef = db.collection('FUNCTION_LOGS');

        // Create a new document with the current timestamp
        const newFunctionLog = {
            timestamp: admin.firestore.FieldValue.serverTimestamp()
        };

        // Add the new document to the FUNCTION_LOGS collection
        await functionLogsRef.add(newFunctionLog);

        console.log('Function log created successfully.');
    } catch (error) {
        console.error('Error creating function log:', error);
    }
});