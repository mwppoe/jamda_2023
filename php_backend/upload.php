<!-- Der Kodierungstyp enctype MUSS wie dargestellt angegeben werden -->
<form enctype="multipart/form-data" action="process.php" method="POST">
    <!-- MAX_FILE_SIZE muss vor dem Datei-Eingabefeld stehen -->
    <input type="hidden" name="MAX_FILE_SIZE" value="3000000" />
    <!-- Der Name des Eingabefelds bestimmt den Namen im $_FILES-Array -->
    Die Buchhaltungsdatei hochladen: <input name="userfile" type="file" />
    <br>
    Passwort: <input type="password" name="password">
    <br>
    <br>
    <input type="submit" value="Send File" />
</form>

