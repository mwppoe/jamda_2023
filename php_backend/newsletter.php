<!-- Der Kodierungstyp enctype MUSS wie dargestellt angegeben werden -->

<?php

use PHPMailer\PHPMailer\PHPMailer;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';


include 'db_conn.inc';
include 'secrets.inc';

if ($_POST['password'] == '') { 

?>
<form enctype="multipart/form-data" action="newsletter.php" method="POST">
    <!-- MAX_FILE_SIZE muss vor dem Datei-Eingabefeld stehen -->

    <label for="state">Newsletter-Versand an</label>
    <select name="state" id="state">
      <option value="2">PB (und CMT)</option>
      <option value="1"> IST (und CMT)</option>
    </select>
    <br>
    Passwort: <input type="password" name="password">
    <input type="checkbox" name="send" value="1"> Mails versenden
   
    <input type="submit" value="Mails vorbereiten..." />
</form>
<?php
} else {

	if ($_POST['password'] == $newsletter_password)  {

	        // Create connection
	        $conn = new mysqli($servername, $username, $password, $dbname);
	
	        // Check connection
	        if ($conn->connect_error) {
	          die("Connection failed: " . $conn->connect_error);
	        }
	
		
	        if ($_POST['state']==1) {
	                $sql = "select distinct people.id as pid, last_name, first_name, email, nickname, status, role_wish, (select count(*) from jamboreepayments where pid=people_id) as payments from people, jamboreepayments where  (role_wish = 'IST' or role_wish = 'CMT') and last_name > 'Seigner%' order by last_name;";
		        $mailfromemail = "ist@jamboree.at";
		        $mailfromtext = "Jamboree 2023 IST Support";
		        $role = "IST";
			$mailsubject = "Jamboree Info #1 - IST";
			$mailtemplate= ",<br><br>es ist soweit: Die Anmeldung zum &ouml;sterreichischen Kontigent f&uuml;r das Jamboree 2023 ist geschlossen - und DU bist mit dabei! Deshalb m&ouml;chten wir dich auch gleich mit den ersten Informationen &uuml;ber das Kontigent, die n&auml;chsten Schritte und wie du zu weitern Informationen kommst, versorgen!<br><br>Damit w&uuml;nschen wir euch f&uuml;r den Moment alles Gute und: n&auml;chstes Jahr fahren wir schon aufs Jamboree :-)<br><br>Die Jamboree News kannst du im Downloadbereich der Jamboree Website unter <a href='https://jamboree.at/downloads'>https://jamboree.at/downloads</a><br>oder direkt hier downloaden: <a href='https://jamboree.at/wp-content/uploads/2022/01/Jamboree-News-IST-1-Willkommen-im-oesterreichischen-Kontingent.pdf'>https://jamboree.at/wp-content/uploads/2022/01/Jamboree-News-IST-1-Willkommen-im-oesterreichischen-Kontingent.pdf</a><br><br>Hier findest du auch die News, die die Teilnehmer*innen erhalten haben: <a href='https://jamboree.at/wp-content/uploads/2022/01/Jamboree-News-1-Willkommen-im-oesterreichischen-Kontingent.pdf'>https://jamboree.at/wp-content/uploads/2022/01/Jamboree-News-1-Willkommen-im-oesterreichischen-Kontingent.pdf</a><br><br>Bei Fragen z&ouml;gere nicht und schreib uns eine E-Mail oder ruf uns an:<br><br>E-Mail: ist@jamboree.at<br>Tel. Madlen: +43 650 4209129<br>Tel. Thomi: +43 664 8662113<br><br>Liebe Gr&uuml;&szlig;e und gut Pfad<br><br>Madlen und Thomi";
		}
	       if ($_POST['state']==2) {
		        $sql = "select people.id as pid, last_name, first_name, email, nickname, status, role_wish from people where (role_wish = 'Teilnehmer*in' or role_wish = 'CMT') and people.id=2  order by last_name;";
		        $mailfromemail = "units@jamboree.at";
			$mailfromtext = "Jamboree 2023 Unit Support";
		        $role = "Teilnehmer*in";
		        $mailsubject = "Jamboree Info #1";
			$mailtemplate = ",<br><br>es ist soweit: Die Anmeldung zum &ouml;sterreichischen Kontigent f&uuml;r das Jamboree 2023 ist geschlossen - und DU bist mit dabei!<br>Deshalb m&ouml;chten wir dich auch gleich mit den ersten Informationen &uuml;ber das Kontigent, die n&auml;chsten Schritte und wie du zu weitern Informationen kommst, versorgen!<br><br>Ausserdem ist es uns sehr wichtig, dass du auch die M&ouml;glichkeit hast, beim Jamboree mitzugestalten. Beachte deshalb bitte ganz besonders den Punkt Jugendpartzipation.<br>Damit w&uuml;nschen wir euch f&uuml;r den Moment alles Gute und: n&auml;chstes Jahr fahren wir schon aufs Jamboree :-)<br><br>Die Jamboree News kannst du im Downloadbereich der Jamboree Website unter <a href='https://jamboree.at/downloads'>https://jamboree.at/downloads</a> oder direkt hier downloaden:<br><a href='https://jamboree.at/wp-content/uploads/2022/01/Jamboree-News-1-Willkommen-im-oesterreichischen-Kontingent.pdf'>https://jamboree.at/wp-content/uploads/2022/01/Jamboree-News-1-Willkommen-im-oesterreichischen-Kontingent.pdf</a><br><br>Beste Gr&uuml;&szlig;e und gut Pfad<br>" . $mailfromtext; 

	       }

	        $r = mysqli_query($conn, $sql);

	        echo "Der folgende Text wird gesendet an:<br>";
	        echo "Von: " . $mailfromemail . " / " . $mailfromtext . "<br><br>";

		echo "Hallo Nickname" . $mailtemplate;
		echo "<br><br>";
	        while ($row = mysqli_fetch_assoc($r))
	         {
	                 echo ("ID: " . $row['pid'] . ", Name: " . utf8_encode($row['last_name']) . " " . utf8_encode($row['first_name']) . ", Scoutcard: " . $row['rdp_association_number'] . " E-Mail: " . $row['email'] . ", Status: " . utf8_encode($row['status']) . " Rolle: " . $row['role_wish'] . " Zahlungen: " . $row['payments']);
	                 echo ("<br>");
	                if ($row['nickname']!='')  $mailtext = "Hallo " . $row['nickname'] . $mailtemplate;
	                else
				$mailtext = "Hallo " . $row['first_name'] . $mailtemplate;
			 
			 if (($row['payments'] == 0) or ($row['status'] == 'registriert'))  {
				 $mailtext = $mailtext . "<br><br><font color='red'>";
				 if (($row['payments'] == 0) and ($row['status'] != 'registriert'))
					$mailtext = $mailtext . "ACHTUNG: Du hast deine Anzahlung noch nicht abgeschlossen. Bitte hole dis unverzüglich nach, damit du mit aufs Jamboree fahren kannst. Zahlungsinformationen findest du in deinem Anmelde-PDF! Die Zahlungsdaten werden immer am 02. und am 16. jeden Monat in der JAMDA aktualisiert."; 
				 if (($row['payments'] > 0) and ($row['status'] == 'registriert'))
					$mailtext = $mailtext . "ACHTUNG: Du hast deine Anmeldung noch nicht vollst&auml;ndig abeschlossen. Bitte hole dis unverz&uuml;glich nach, damit du mit aufs Jamboree fahren kannst.";
	 			if (($row['payments'] == 0) and ($row['status'] == 'registriert'))
					$mailtext = $mailtext . "ACHTUNG: Du hast deine Anzahlung noch nicht abgeschlossen. Ausserdem hast &nbsp;du deine Anzahlung noch nicht abgeschlossen.Bitte hole dis unverz&uuml;glich nach, damit du mit aufs Jamboree fahren kannst. Zahlungsinformationen findest du in deinem Anmelde-PDF! Die Zahlungsdaten werden immer am 02. und am 16. jeden Monat in der JAMDA aktualisiert.";
			$mailtext = $mailtext . "</font>";
			 }
			echo $mailtext . "<br><br>";
 
			 if ($_POST['send']){
	                        $mail = new PHPMailer;
	                        $mail->isSMTP();
	                        $mail->SMTPDebug = 1;
	                        $mail->Host = 'smtp.outlook.com';
	                        $mail->Port = 587;
	                        $mail->SMTPAuth = true;
	                        $mail->Username = $smtp_user;
	                        $mail->Password = $smtp_password;
	                        $mail->setFrom($mailfromemail , $mailfromtext);
	                        $mail->addReplyTo($mailfromemail , $mailfromtext);
	                        $mail->addAddress($row['email']);
	                        //$mail->AddCC($mailfromemail);
	                        $mail->AddBCC('manuel.woletz@ppoe.at');
	                        $mail->Subject = $mailsubject;
	                        $mail->msgHTML(file_get_contents('message.html'), __DIR__);
	                        $mail->Body = $mailtext;
	                        if (!$mail->send()) {
	                         echo 'Mailer Error: ' . $mail->ErrorInfo;
	                        } else {
	                            echo 'The email message was sent.';
	
	                        }
	                }
	        }
	        if ($_POST['send']!=1){
	                echo "<br><br>Mails wurden noch NICHT versendet! Zum Versenden die Checkbox auswählen!<br>";
	        }



	}
	else {
		 echo "Falsches Passwort!";
	}
}
?>
