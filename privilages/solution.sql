CREATE DATABASE vtapp;

CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'Buttersc0tc#';

GRANT ALL ON vtapp.* To 'vtapp_user'@'localhost';
