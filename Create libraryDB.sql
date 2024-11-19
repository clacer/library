-- Создание базы данных
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Таблица для авторов
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный идентификатор автора',
    FirstName VARCHAR(255) NOT NULL COMMENT 'Имя автора',
    LastName VARCHAR(255) NOT NULL COMMENT 'Фамилия автора',
    DateOfBirth DATE COMMENT 'Дата рождения автора',
    Nationality VARCHAR(255) COMMENT 'Национальность автора'
) COMMENT 'Таблица для хранения данных об авторах';

-- Таблица для жанров
CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный идентификатор жанра',
    GenreName VARCHAR(255) NOT NULL COMMENT 'Название жанра'
) COMMENT 'Таблица для хранения данных о жанрах книг';

-- Таблица для книг
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный идентификатор книги',
    Title VARCHAR(255) NOT NULL COMMENT 'Название книги',
    ISBN VARCHAR(20) UNIQUE NOT NULL COMMENT 'Международный стандартный номер книги',
    PublicationYear YEAR COMMENT 'Год издания книги',
    Publisher VARCHAR(255) COMMENT 'Издатель книги',
    Description TEXT COMMENT 'Описание или аннотация книги',
    Pages INT COMMENT 'Количество страниц в книге'
) COMMENT 'Таблица для хранения информации о книгах';

-- Таблица для связи книг и жанров (многие-ко-многим)
CREATE TABLE BookGenre (
    BookID INT NOT NULL COMMENT 'Идентификатор книги',
    GenreID INT NOT NULL COMMENT 'Идентификатор жанра',
    PRIMARY KEY (BookID, GenreID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE CASCADE
) COMMENT 'Связь многие-ко-многим между книгами и жанрами';

-- Таблица для экземпляров книг
CREATE TABLE BookCopies (
    CopyID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный идентификатор экземпляра книги',
    BookID INT NOT NULL COMMENT 'Идентификатор книги, к которой относится экземпляр',
    StatusID INT NOT NULL COMMENT 'Статус экземпляра книги',
    Location VARCHAR(255) COMMENT 'Местоположение экземпляра книги (например, "Шкаф А, полка 2")',
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
) COMMENT 'Таблица для хранения информации об экземплярах книг';

-- Таблица для статусов экземпляров книг
CREATE TABLE BookStatuses (
    StatusID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный идентификатор статуса',
    StatusName VARCHAR(50) NOT NULL COMMENT 'Название статуса (например, "Доступна")'
) COMMENT 'Таблица для хранения статусов экземпляров книг';

-- Таблица для пользователей
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный идентификатор пользователя',
    FirstName VARCHAR(255) NOT NULL COMMENT 'Имя пользователя',
    LastName VARCHAR(255) NOT NULL COMMENT 'Фамилия пользователя',
    Email VARCHAR(255) UNIQUE NOT NULL COMMENT 'Электронная почта пользователя',
    Pass VARCHAR(255) NOT NULL COMMENT 'Хэшированный пароль пользователя',
    Address VARCHAR(255) COMMENT 'Адрес проживания пользователя',
    Phone VARCHAR(20) COMMENT 'Номер телефона пользователя',
    MembershipDate DATE DEFAULT CURRENT_DATE COMMENT 'Дата регистрации пользователя',
    IsActive TINYINT(1) DEFAULT 1 COMMENT 'Статус активности пользователя (1 — активен, 0 — неактивен)'
) COMMENT 'Таблица для хранения информации о пользователях';