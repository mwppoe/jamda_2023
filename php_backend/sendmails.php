<!-- Der Kodierungstyp enctype MUSS wie dargestellt angegeben werden -->
<form enctype="multipart/form-data" action="emails.php" method="POST">
    <!-- MAX_FILE_SIZE muss vor dem Datei-Eingabefeld stehen -->

    <label for="state">Welcher Mailversand?</label>
    <select name="state" id="state">
      <option value="1">IST Daten fehlen</option>
      <option value="2">Units Daten fehlen</option>
      <option value="3">Zahlungen fehlen</option>
    </select>
    <br>
    Passwort: <input type="password" name="password">
    <input type="checkbox" name="send" value="1"> Mails versenden
   
    <input type="submit" value="Mails vorbereiten..." />
</form>

