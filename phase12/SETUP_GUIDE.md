# Arabic Dictionary System - Phase 1 Setup Guide

## Overview
This is a complete CRUD application for managing Arabic Roots and Patterns using JavaFX GUI and MySQL database (XAMPP).

## Prerequisites
- Java JDK 11 or higher
- XAMPP (MySQL Server)
- JavaFX SDK 21 or compatible version
- IDE: IntelliJ IDEA or Eclipse

## Step 1: Install and Configure XAMPP

### Windows/Mac/Linux:
1. Download XAMPP from https://www.apachefriends.org/
2. Install XAMPP
3. Start XAMPP Control Panel
4. Click "Start" for Apache and MySQL

### Verify MySQL is Running:
- Open browser and go to http://localhost/phpmyadmin
- You should see phpMyAdmin interface

## Step 2: Create Database

### Option A: Using phpMyAdmin (GUI)
1. Open http://localhost/phpmyadmin
2. Click "New" on the left sidebar
3. Enter database name: `dictionary`
4. Click "Create"
5. Select the `dictionary` database
6. Go to "SQL" tab
7. Copy and paste the contents of `database-setup.sql`
8. Click "Go"

### Option B: Using MySQL Command Line
1. Open Command Prompt/Terminal
2. Navigate to XAMPP MySQL bin folder:
   \`\`\`
   cd C:\xampp\mysql\bin  (Windows)
   cd /Applications/XAMPP/bin  (Mac)
   cd /opt/lampp/bin  (Linux)
   \`\`\`
3. Connect to MySQL:
   \`\`\`
   mysql -u root -p
   \`\`\`
   (Press Enter when prompted for password - default is empty)

4. Run the SQL commands:
   \`\`\`sql
   CREATE DATABASE IF NOT EXISTS dictionary;
   USE dictionary;
   
   CREATE TABLE IF NOT EXISTS roots (
       id INT AUTO_INCREMENT PRIMARY KEY,
       rootLetters VARCHAR(50) NOT NULL UNIQUE,
       createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   
   CREATE TABLE IF NOT EXISTS patterns (
       id INT AUTO_INCREMENT PRIMARY KEY,
       patternForm VARCHAR(100) NOT NULL UNIQUE,
       createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   
   INSERT INTO roots (rootLetters) VALUES 
   ('ك ت ب'),
   ('د ر س'),
   ('ع ل م'),
   ('ف ه م'),
   ('ق ر أ');
   
   INSERT INTO patterns (patternForm) VALUES 
   ('فَعَلَ'),
   ('فِعْلٌ'),
   ('فَاعِلٌ'),
   ('مَفْعُولٌ'),
   ('فُعُولٌ'),
   ('فِعَالٌ'),
   ('فَعِيلٌ'),
   ('فَعْلَانٌ');
   \`\`\`

## Step 3: Verify Database Setup

1. In phpMyAdmin, select `dictionary` database
2. You should see two tables: `roots` and `patterns`
3. Click on each table to verify sample data is inserted

## Step 4: Configure IDE Project

### IntelliJ IDEA:
1. Open the project in IntelliJ
2. Go to File → Project Structure → Libraries
3. Click "+" and add MySQL JDBC Driver:
   - Download from: https://dev.mysql.com/downloads/connector/j/
   - Or use Maven: Add to pom.xml if using Maven
4. Add JavaFX SDK:
   - Download from: https://gluonhq.com/products/javafx/
   - Add to Project Structure → Libraries

### Eclipse:
1. Right-click project → Build Path → Configure Build Path
2. Add External JARs:
   - mysql-connector-java-x.x.x.jar
   - javafx-sdk/lib/*.jar

## Step 5: Update Database Connection (if needed)

File: `src/com/dictionary/database/DatabaseConnection.java`

Current configuration:
\`\`\`java
DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/dictionary?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC", 
    "root", "");
\`\`\`

- Host: localhost
- Port: 3306
- Database: dictionary
- Username: root
- Password: (empty - default XAMPP)

If you set a MySQL password, update the last parameter:
\`\`\`java
DriverManager.getConnection(url, "root", "your_password");
\`\`\`

## Step 6: Run the Application

### Run RootUI:
\`\`\`bash
java -cp ".:mysql-connector-java-x.x.x.jar" com.dictionary.ui.RootUI
\`\`\`

### Run PatternUI:
\`\`\`bash
java -cp ".:mysql-connector-java-jar" com.dictionary.ui.PatternUI
\`\`\`

Or use IDE's Run button after configuring run configurations.

## Project Structure

\`\`\`
src/
├── com/dictionary/
│   ├── database/
│   │   └── DatabaseConnection.java      (MySQL connection)
│   ├── model/
│   │   ├── RootDTO.java                 (Root data model)
│   │   └── PatternDTO.java              (Pattern data model)
│   ├── dao/
│   │   ├── RootDAO.java                 (Root database operations)
│   │   └── PatternDAO.java              (Pattern database operations)
│   ├── service/
│   │   ├── IRootService.java            (Root service interface)
│   │   ├── RootService.java             (Root business logic)
│   │   ├── IPatternService.java         (Pattern service interface)
│   │   └── PatternService.java          (Pattern business logic)
│   └── ui/
│       ├── RootUI.java                  (Root JavaFX GUI)
│       └── PatternUI.java               (Pattern JavaFX GUI)
\`\`\`

## Features

### Root Management:
- Add new roots with Arabic letters
- View all roots in table
- Update existing roots
- Delete roots with confirmation
- Duplicate prevention

### Pattern Management:
- Add new patterns with Arabic forms
- View all patterns in table
- Update existing patterns
- Delete patterns with confirmation
- Duplicate prevention

## Troubleshooting

### Issue: "No suitable driver found"
- Solution: Ensure mysql-connector-java JAR is in classpath

### Issue: "Connection refused"
- Solution: Verify MySQL is running in XAMPP Control Panel

### Issue: "Access denied for user 'root'"
- Solution: Check password in DatabaseConnection.java matches XAMPP MySQL password

### Issue: "Database 'dictionary' doesn't exist"
- Solution: Run database-setup.sql to create tables

### Issue: JavaFX not loading
- Solution: Add JavaFX SDK to VM options:
  \`\`\`
  --module-path /path/to/javafx-sdk/lib --add-modules javafx.controls,javafx.fxml
  \`\`\`

## Next Steps (Phase 2)

- Add Word management with CRUD
- Add Example management
- Add Metadata management
- Create unified dashboard with all entities
- Add search and filter functionality
- Add data export/import features

## Support

For issues or questions:
1. Check database connection in phpMyAdmin
2. Verify all JAR files are in classpath
3. Check console for detailed error messages
4. Ensure XAMPP MySQL is running
