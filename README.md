## Chat Application Documentation

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [User Guide](#user-guide)
    1. [Getting Started](#getting-started)
    2. [Using the Chat](#using-the-chat)
    3. [Settings](#settings)
4. [API Documentation](#api-documentation)
    1. [Authentication](#authentication)
    2. [Sending Messages](#sending-messages)
    3. [Receiving Messages](#receiving-messages)
    4. [User Management](#user-management)
5. [Troubleshooting](#troubleshooting)
6. [FAQ](#faq)
7. [Contact Support](#contact-support)

---

## Overview

The Chat Application is a real-time messaging platform designed for seamless communication. It allows users to send and receive messages instantly, manage contacts, and customize their chatting experience. This documentation provides a comprehensive guide to using and understanding the features of the chat application.

---

## Features

- **Real-time Messaging**: Send and receive messages instantly.
- **Group Chats**: Create and manage group conversations.
- **Media Sharing**: Share images, videos, and files.
- **Notifications**: Receive alerts for new messages.
- **User Profiles**: Customize user profiles with avatars and status messages.
- **Message Search**: Quickly find past messages.
- **Encryption**: Secure messages with end-to-end encryption.
- **Cross-Platform**: Available on web, iOS, and Android.

---

## User Guide

### Getting Started

1. **Sign Up**
   - Open the chat application.
   - Click on "Sign Up."
   - Fill in the required details (username, email, password).
   - Click "Create Account."
   - Verify your email if prompted.

2. **Log In**
   - Open the chat application.
   - Enter your username and password.
   - Click "Log In."

### Using the Chat

1. **Starting a New Chat**
   - Click on the "New Chat" button.
   - Select a contact from your list or search for a user.
   - Type your message in the text box and hit "Send."

2. **Joining a Group Chat**
   - Click on the "Groups" tab.
   - Select a group or click "Join Group" and enter the group code.

3. **Sending Media**
   - Click on the attachment icon (usually a paperclip).
   - Choose the type of media (photo, video, file).
   - Select the file from your device and click "Send."

### Settings

1. **Profile Settings**
   - Go to the "Profile" tab.
   - Click "Edit Profile."
   - Update your avatar, status message, and other personal information.
   - Click "Save."

2. **Notification Settings**
   - Go to the "Settings" tab.
   - Click on "Notifications."
   - Customize your notification preferences.

---

## API Documentation

### Authentication

- **Endpoint**: `/api/auth/login`
  - **Method**: POST
  - **Parameters**: 
    - `username` (string)
    - `password` (string)
  - **Response**: 
    - `token` (string): Authentication token

### Sending Messages

- **Endpoint**: `/api/messages/send`
  - **Method**: POST
  - **Headers**: 
    - `Authorization` (string): Bearer token
  - **Parameters**: 
    - `recipient_id` (string): ID of the recipient
    - `message` (string): The message content
  - **Response**: 
    - `message_id` (string): ID of the sent message

### Receiving Messages

- **Endpoint**: `/api/messages/receive`
  - **Method**: GET
  - **Headers**: 
    - `Authorization` (string): Bearer token
  - **Parameters**: None
  - **Response**: 
    - `messages` (array): List of messages

### User Management

- **Endpoint**: `/api/users`
  - **Method**: GET
  - **Headers**: 
    - `Authorization` (string): Bearer token
  - **Parameters**: None
  - **Response**: 
    - `users` (array): List of users

---

## Troubleshooting

1. **Cannot Log In**
   - Ensure your username and password are correct.
   - Check your internet connection.
   - Try resetting your password.

2. **Messages Not Sending**
   - Verify your internet connection.
   - Check if the recipient is still in your contact list.
   - Restart the application.

3. **Notification Issues**
   - Ensure notifications are enabled in the app settings.
   - Check your device's notification settings.
   - Restart the application.

---
## Screenshots

| Image 1 | Image 2 | Image 3 | Image 4 | Image 5 |
|---------|---------|---------|---------|---------|
| <img src="https://github.com/rajbha9/chating_app/assets/135328342/bcaea13a-b1d3-42c4-9e34-21cd3bd543d3" width="200" height="400"> | <img src="https://github.com/rajbha9/chating_app/assets/135328342/187d00bd-4249-4643-98e9-93c898e05a28" width="200" height="400"> | <img src="https://github.com/rajbha9/chating_app/assets/135328342/4a0037cd-634e-4a65-a3a5-01121bb1e7fe" width="200" height="400"> | <img src="https://github.com/rajbha9/chating_app/assets/135328342/66730059-c8bc-48ec-aa97-71cac8092c75" width="200" height="400"> | <img src="https://github.com/rajbha9/chating_app/assets/135328342/e2d213b5-e42c-4298-a2dc-8c12d9a47221" width="200" height="400"> | 
<img src="https://github.com/rajbha9/chating_app/assets/135328342/ebeecd5f-b9e6-4205-a59f-fce732aa5011" width="200" height="400"> | <img src="https://github.com/rajbha9/chating_app/assets/135328342/46008add-37ce-420e-b604-6050656d3b5e" width="200" height="400"> | <img src="https://github.com/rajbha9/chating_app/assets/135328342/15b75310-5632-4c55-ab6e-37d878a3b105" width="200" height="400"> | <img src="https://github.com/rajbha9/chating_app/assets/135328342/ce475406-f1c3-4d77-8913-40ee04183745" width="200" height="400">
