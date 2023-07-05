// here we'll store all the variables and statements
// which we'll use in overall project
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance; // add authentication to firebase
FirebaseFirestore firestore =
    FirebaseFirestore.instance; // to store data in firebase
User? currentUser = auth.currentUser; // to get data of logined user
 
// collections: to use variables instead of strings
const usersCollection = "users";
const productsCollection = "products";
const cartCollection = 'cart';
const chatsCollection = 'chats';
const messagesCollection = 'messages';
const ordersCollection = 'orders';
