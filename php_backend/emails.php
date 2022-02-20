<?php

use PHPMailer\PHPMailer\PHPMailer;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

include 'secrets.inc';
include 'db_conn.inc';

echo $ist_mailing;

if (   (($_POST['password'] == $ist_mailing) && ($_POST['state']==1)) || (($_POST['password'] == $pb_mailing) && ($_POST['state']==2))   || (($_POST['password'] == $fin_mailing) &&  ($_POST['state']==3)) ) {
	
	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);
	
	// Check connection
	if ($conn->connect_error) {
	  die("Connection failed: " . $conn->connect_error);
	}



	if ($_POST['state']==1) {
		$sql = "select people.id as pid, last_name, first_name, email, nickname, status, role_wish from people where status = 'registriert' and role_wish = 'IST'  order by last_name";
        $mailfromemail = "ist@jamboree.at";
        $mailfromtext = "Jamboree 2023 IST Support";
	$role = "IST";
	$mailsubject = "Deine Anmeldung zum Jamboree 2023";
        $mailtemplate = ", <br><br>du hast dich bereits in der Jamda f&uuml;r das Jamboree 2023 in S&uuml;dkorea als " . $role . " regstiert. Im n&auml;chsten Schritt bitten wir dich darum, deine Daten vollst&auml;ndig auszuf&uuml;llen und die Anmeldung abzuschlie&szlig;en.<br><br>Solltest du nicht mehr auf das Jamboree 2023 mitfahren wollen, teile uns dies bitte mit.<br><br>Beste Gr&uuml;&szlig;e und gut Pfad<br><br>" . $mailfromtext . "<br><br>Link zur Jamda: <a href='https://jamda.jamboree.at'>https://jamda.jamboree.at</a><br><br>Wir w&uuml;nschen wir dir frohe Weihnachten und einen guten Rutsch ins neue Jahr!<br><br>";

	}
	if ($_POST['state']==2) {
		$sql = "select people.id as pid, last_name, first_name, email, nickname, status, role_wish from people where status = 'registriert' and role_wish = 'Teilnehmer*in' order by last_name";
        $mailfromemail = "units@jamboree.at";
	$mailfromtext = "Jamboree 2023 Unit Support";
	$role = "Teilnehmer*in";
	$mailsubject = "Deine Anmeldung zum Jamboree 2023";
        $mailtemplate = ", <br><br>du hast dich bereits in der Jamda f&uuml;r das Jamboree 2023 in S&uuml;dkorea als " . $role . " regstiert. Im n&auml;chsten Schritt bitten wir dich darum, deine Daten vollst&auml;ndig auszuf&uuml;llen und die Anmeldung abzuschlie&szlig;en.<br><br>Solltest du nicht mehr auf das Jamboree 2023 mitfahren wollen, teile uns dies bitte mit.<br><br>Beste Gr&uuml;&szlig;e und gut Pfad<br><br>" . $mailfromtext . "<br><br>Link zur Jamda: <a href='https://jamda.jamboree.at'>https://jamda.jamboree.at</a><br><br>Wir w&uuml;nschen wir dir frohe Weihnachten und einen guten Rutsch ins neue Jahr!<br><br>";


	}
	if ($_POST['state']==3) {
		$sql = "select people.id as pid, last_name, first_name, rdp_association_number, email, nickname, status, role_wish from people where id not in (select people_id from jamboreepayments) and (role_wish = 'IST' or role_wish = 'Teilnehmer*in');";
		$mailfromemail = "jamda@ppoe.at";
		$mailfromtext = "Jamboree 2023";
		$mailsubject = "Deine Abmeldung vom Jamboree 2023";
		$mailtemplate = ", <br><br>wir haben von dir bis jetzt keine Anzahlung erhalten. Diese war bereits vor &uuml;ber einem Monat (31.12.2021) f&auml;llig. Aus diesem Grund k&ouml;nnen wir deine Anmeldung nicht ber&uuml;cksichtigen.<br><br>Deine Daten werden mit 6. Februar aus der Jamda Datenbank gel&ouml;scht.<br><br>Beste Gr&uuml;&szlig;e und gut Pfad<br><br>" . $mailfromtext . "<br><br>Link zur Jamda: <a href='https://jamda.jamboree.at'>https://jamda.jamboree.at</a><br><br>";

	}

        #$sql = "select people.id as pid, last_name, first_name, rdp_association_number, amount, booking_number, booking_date  from people, jamboreepayments where jamboreepayments.people_id = people.id order by people.id;";
	$r = mysqli_query($conn, $sql);

	echo "Der folgende Text wird gesendet an:<br>";
	echo "Von: " . $mailfromemail . " / " . $mailfromtext . "<br><br>";

	echo "Hallo Nickname" . $mailtemplate;
        while ($row = mysqli_fetch_assoc($r))
         {
                 echo ("ID: " . $row['pid'] . ", Name: " . utf8_encode($row['last_name']) . " " . utf8_encode($row['first_name']) . ", Scoutcard: " . $row['rdp_association_number'] . " E-Mail: " . $row['email'] . ", Status: " . $row['status'] . "Rolle: " . $row['role_wish']);
		 echo ("<br>");
		if ($row['nickname']!='')  $mailtext = "Hallo " . $row['nickname'] . $mailtemplate;
		else
		   $mailtext = "Hallo " . $row['first_name'] . $mailtemplate;
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
?>
