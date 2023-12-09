CREATE DATABASE "aims" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE "deliveryinformation" (
  "id" int NOT NULL AUTO_INCREMENT,
  "address" varchar(100) NOT NULL,
  "province" varchar(45) NOT NULL,
  "name" varchar(45) NOT NULL,
  "phone" varchar(20) NOT NULL,
  "shipping_method" int NOT NULL,
  "instructions" varchar(200) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "media" (
  "id" int NOT NULL AUTO_INCREMENT,
  "price" int NOT NULL,
  "category" varchar(45) NOT NULL,
  "value" int NOT NULL,
  "quantity" int NOT NULL,
  "title" varchar(100) NOT NULL,
  "imageUrl" varchar(200) DEFAULT NULL,
  PRIMARY KEY ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "book" (
  "id" int NOT NULL,
  "author" varchar(45) NOT NULL,
  "cover_type" varchar(45) NOT NULL,
  "number_of_pages" int NOT NULL,
  "language" varchar(45) NOT NULL,
  "book_category" varchar(45) NOT NULL,
  "publisher" varchar(100) NOT NULL,
  "publish_date" datetime NOT NULL,
  KEY "media_book_idx" ("id"),
  CONSTRAINT "fk_media_book" FOREIGN KEY ("id") REFERENCES "media" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "cd" (
  "id" int NOT NULL,
  "artist" varchar(45) NOT NULL,
  "record_label" varchar(45) NOT NULL,
  "music_type" varchar(45) NOT NULL,
  "track_list" varchar(200) DEFAULT NULL,
  "release_date" datetime DEFAULT NULL,
  KEY "media_cd_idx" ("id"),
  CONSTRAINT "fk_media_cd" FOREIGN KEY ("id") REFERENCES "media" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "dvd" (
  "id" int NOT NULL,
  "director" varchar(45) NOT NULL,
  "disk_type" varchar(45) NOT NULL,
  "subtitle" varchar(45) NOT NULL,
  "studio" varchar(45) NOT NULL,
  "language" varchar(45) NOT NULL,
  "runtime" int NOT NULL,
  "release_date" datetime NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_dvd_media" FOREIGN KEY ("id") REFERENCES "media" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "lp" (
  "id" int NOT NULL,
  "artist" varchar(45) NOT NULL,
  "record_label" varchar(45) NOT NULL,
  "music_type" varchar(45) NOT NULL,
  "track_list" varchar(200) DEFAULT NULL,
  "release_date" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_lp_media" FOREIGN KEY ("id") REFERENCES "media" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "card" (
  "id" int NOT NULL AUTO_INCREMENT,
  "card_number" varchar(45) NOT NULL,
  "card_holder_name" varchar(45) NOT NULL,
  "issuing_bank" varchar(45) NOT NULL,
  "bank_code" varchar(45) NOT NULL,
  "expiredAt" datetime NOT NULL,
  PRIMARY KEY ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "order" (
  "id" int NOT NULL,
  "shipping_fee" double NOT NULL,
  "delivery_info_id" int NOT NULL,
  PRIMARY KEY ("id"),
  KEY "fk_order_delivery_idx" ("delivery_info_id"),
  CONSTRAINT "fk_order_delivery" FOREIGN KEY ("delivery_info_id") REFERENCES "deliveryinformation" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "order_media" (
  "id" int NOT NULL AUTO_INCREMENT,
  "media_id" int NOT NULL,
  "order_id" int NOT NULL,
  "price" double NOT NULL,
  "quantity" int NOT NULL,
  PRIMARY KEY ("id"),
  KEY "fk_order_media_media_idx" ("media_id"),
  KEY "fk_order_media_order_idx" ("order_id"),
  CONSTRAINT "fk_order_media_media" FOREIGN KEY ("media_id") REFERENCES "media" ("id"),
  CONSTRAINT "fk_order_media_order" FOREIGN KEY ("order_id") REFERENCES "order" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "invoice" (
  "id" int NOT NULL,
  "total_amount" int NOT NULL,
  "total_price" double NOT NULL,
  "order_id" int NOT NULL,
  PRIMARY KEY ("id"),
  KEY "fk_invoice_order_idx" ("order_id"),
  CONSTRAINT "fk_invoice_order" FOREIGN KEY ("order_id") REFERENCES "order" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE "paymenttransaction" (
  "id" int NOT NULL AUTO_INCREMENT,
  "amount" int NOT NULL,
  "content" varchar(100) NOT NULL,
  "method" varchar(45) NOT NULL,
  "transaction_time" datetime NOT NULL,
  "error_message" varchar(100) NOT NULL,
  "card_id" int NOT NULL,
  "invoice_id" int NOT NULL,
  PRIMARY KEY ("id"),
  KEY "fk_payment_card_idx" ("card_id"),
  KEY "fk_payment_invoice_idx" ("invoice_id"),
  CONSTRAINT "fk_payment_card" FOREIGN KEY ("card_id") REFERENCES "card" ("id"),
  CONSTRAINT "fk_payment_invoice" FOREIGN KEY ("invoice_id") REFERENCES "invoice" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;









