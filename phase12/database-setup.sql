-- Create Dictionary Database
CREATE DATABASE IF NOT EXISTS dictionary;
USE dictionary;

-- Create Roots Table
CREATE TABLE IF NOT EXISTS roots (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rootLetters VARCHAR(50) NOT NULL UNIQUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Patterns Table
CREATE TABLE IF NOT EXISTS patterns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patternForm VARCHAR(100) NOT NULL UNIQUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add Words Table with metadata and foreign keys
CREATE TABLE IF NOT EXISTS words (
    id INT AUTO_INCREMENT PRIMARY KEY,
    word VARCHAR(100) NOT NULL,
    rootId INT NOT NULL,
    patternId INT NOT NULL,
    meaning TEXT,
    example TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rootId) REFERENCES roots(id) ON DELETE CASCADE,
    FOREIGN KEY (patternId) REFERENCES patterns(id) ON DELETE CASCADE,
    INDEX idx_root (rootId),
    INDEX idx_pattern (patternId)
);

-- Insert Sample Roots
INSERT INTO roots (rootLetters) VALUES 
('ك ت ب'),
('د ر س'),
('ع ل م'),
('ف ه م'),
('ق ر أ');

-- Insert Sample Patterns
INSERT INTO patterns (patternForm) VALUES 
('فَعَلَ'),
('فِعْلٌ'),
('فَاعِلٌ'),
('مَفْعُولٌ'),
('فُعُولٌ'),
('فِعَالٌ'),
('فَعِيلٌ'),
('فَعْلَانٌ');

-- Add sample words
INSERT INTO words (word, rootId, patternId, meaning, example) VALUES 
('كتاب', 1, 2, 'Book', 'قرأت كتاباً جميلاً'),
('كاتب', 1, 3, 'Writer', 'الكاتب يكتب الرسالة'),
('درس', 2, 1, 'Lesson', 'درس الطالب الدرس'),
('معلم', 3, 3, 'Teacher', 'المعلم يعلم الطلاب'),
('قارئ', 5, 3, 'Reader', 'القارئ يقرأ الكتاب');
