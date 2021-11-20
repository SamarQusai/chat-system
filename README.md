# About Chat System
* This a simple base for chat system.
* You can create multiple applications, each application has its own token.
* For each application, you can create multiple chats, each chat has number.
* For each chat, you can send multiple messages, each message has number.
* You can search inside chat about specific message.
* You can know how many chats belong to specific application and how many messages belong to specific chat.

Built With
------------
* **Ruby** version 2.6.7 
* **Rails** version 5.2.6 
* **MySQL** version 5.2.6 
* **Redis** 
* **Elasticsearch** 
* **Sidekiq** 

Requirements
------------
* Docker

How to run
--------
```bash
$ git clone git@github.com:SamarQusai/chat-system.git
$ cd chat-system/
$ docker-compose up
```
APIs (Postman)
-------------
* Import [this json](https://www.postman.com/collections/a1da6a5af82a21ca938c) to postman. <br/>
  https://www.postman.com/collections/a1da6a5af82a21ca938c