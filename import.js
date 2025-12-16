const admin = require("firebase-admin");
const fs = require("fs");

admin.initializeApp({
  credential: admin.credential.cert(require("./serviceAccountKey.json")),
});

const db = admin.firestore();
const data = JSON.parse(fs.readFileSync("testf_data.json", "utf8"));

async function importData() {
  for (const [collectionName, documents] of Object.entries(data)) {
    for (const [docId, docData] of Object.entries(documents)) {
      await db.collection(collectionName).doc(docId).set({
        ...docData,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
  }
  console.log("✅ Firestore import completed successfully");
}

importData().catch(console.error);
