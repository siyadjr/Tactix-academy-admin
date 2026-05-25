importScripts("https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.1/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyDKtWBjtANeNmIDS2xy89T-Lk2xZQbCbbI",
  appId: "1:482963155468:web:a85c43147270cdc001dc29",
  messagingSenderId: "482963155468",
  projectId: "tactix-academy-e9b38",
  authDomain: "tactix-academy-e9b38.firebaseapp.com",
  storageBucket: "tactix-academy-e9b38.firebasestorage.app"
});

const messaging = firebase.messaging();

// Handle background notifications
messaging.onBackgroundMessage((payload) => {
  console.log("Received background message ", payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: "/icons/Icon-192.png"
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});
