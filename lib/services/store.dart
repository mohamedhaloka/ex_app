import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/const.dart';

class Store {
  FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  storeUserDate(id, data) async {
    print("Done - Store UserData");
    await _firebaseFireStore.collection(kUserCollection).doc(id).set(data);
  }

  Stream<QuerySnapshot> getUsers() {
    print("Done - get Users");
    return _firebaseFireStore.collection(kUserCollection).snapshots();
  }

  storeUsersChatMessage(id, userId,
      {username,
      username2,
      toLocalId,
      fromLocalId,
      messageTittle,
      mePhoto,
      userPhoto,
      dateTime,
      newMessageLocal,
      newMessage}) async {
    print("Done - Store Message");
    await _firebaseFireStore
        .collection(kUserCollection)
        .doc(id)
        .collection(kUsersChatCollection)
        .doc(userId)
        .set({
      kUserName: username,
      kToUser: toLocalId,
      kFromUser: fromLocalId,
      kMessageTittle: messageTittle,
      kMessageTime: dateTime,
      kUserPhoto: userPhoto,
      kNewMessage: newMessageLocal
    });

    await _firebaseFireStore
        .collection(kUserCollection)
        .doc(userId)
        .collection(kUsersChatCollection)
        .doc(id)
        .set({
      kUserName: username2,
      kToUser: toLocalId,
      kFromUser: fromLocalId,
      kMessageTittle: messageTittle,
      kMessageTime: dateTime,
      kUserPhoto: mePhoto,
      kNewMessage: newMessage
    });
  }

  updateUsersChatMessages(localId, anotherUserId) async {
    await _firebaseFireStore
        .collection(kUserCollection)
        .doc(localId)
        .collection(kUsersChatCollection)
        .doc(anotherUserId)
        .update({kNewMessage: false});
  }

  storeMessage(id, data, anotherUserId) async {
    print("Done - Store Message");
    await _firebaseFireStore
        .collection(kUserCollection)
        .doc(id)
        .collection(kUsersChatCollection)
        .doc(anotherUserId)
        .collection(kMessagesCollection)
        .doc()
        .set(data);

    await _firebaseFireStore
        .collection(kUserCollection)
        .doc(anotherUserId)
        .collection(kUsersChatCollection)
        .doc(id)
        .collection(kMessagesCollection)
        .doc()
        .set(data);
  }

  Stream<QuerySnapshot> getMessages(id, userId) {
    print("Done - get Messages");
    return _firebaseFireStore
        .collection(kUserCollection)
        .doc(id)
        .collection(kUsersChatCollection)
        .doc(userId)
        .collection(kMessagesCollection)
        .orderBy(kMessageTime, descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserChatMessages(id) {
    print("Done - get User Message");
    return _firebaseFireStore
        .collection(kUserCollection)
        .doc(id)
        .collection(kUsersChatCollection)
        .orderBy(kMessageTime, descending: true)
        .snapshots();
  }

  editProfile(id, data) async {
    await _firebaseFireStore.collection(kUserCollection).doc(id).update(data);
  }

  deleteMessage(id, anotherUserId, messageID) {
    print("Done - Delete Message");
    return _firebaseFireStore
        .collection(kUserCollection)
        .doc(id)
        .collection(kUsersChatCollection)
        .doc(anotherUserId)
        .collection(kMessagesCollection)
        .doc(messageID)
        .delete();
  }

  deleteChat(id, anotherUserId) {
    print("Done - Delete Chat");
    return _firebaseFireStore
        .collection(kUserCollection)
        .doc(id)
        .collection(kUsersChatCollection)
        .doc(anotherUserId)
        .delete();
  }

  deleteChatMessages(id, anotherUserId) {
    print("Done - Delete Chat");
    return _firebaseFireStore
        .collection(kUserCollection)
        .doc(id)
        .collection(kUsersChatCollection)
        .doc(anotherUserId)
        .collection(kMessagesCollection)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
