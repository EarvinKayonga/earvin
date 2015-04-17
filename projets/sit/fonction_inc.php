<?php
function debug($arg){
	echo "<pre>"; print_r($arg); echo "</pre>";
	$info = debug_backtrace();
	echo "<pre>"; print_r($info); echo "</pre>";
	echo "Fichier: " . $info[0]['file'] ."<br>";
	echo "Ligne: " . $info[0]['line'] ."<br>";
}
 //-------------------------------------------------------
function execute_requete($arg){
	global $mysqli;
	$resultat = $mysqli->query($arg);
	if ($mysqli->error){
		echo "Erreur SQL ". $mysqli->error . "<br/>";
		echo "Requete: " .$arg;
	}
	return $resultat;
}

//-----------------------------------------------------
function utilisateur_est_connecte(){
	if (isset($_SESSION['utilisateur'])) {
		return true;
	}
	return false;
}


//--------------------------------------------------------------
function get_client_ip()
 {
      $ipaddress = '';
      if (getenv('HTTP_CLIENT_IP'))
          $ipaddress = getenv('HTTP_CLIENT_IP');
      else if(getenv('HTTP_X_FORWARDED_FOR'))
          $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
      else if(getenv('HTTP_X_FORWARDED'))
          $ipaddress = getenv('HTTP_X_FORWARDED');
      else if(getenv('HTTP_FORWARDED_FOR'))
          $ipaddress = getenv('HTTP_FORWARDED_FOR');
      else if(getenv('HTTP_FORWARDED'))
          $ipaddress = getenv('HTTP_FORWARDED');
      else if(getenv('REMOTE_ADDR'))
          $ipaddress = getenv('REMOTE_ADDR');
      else
          $ipaddress = 'UNKNOWN';

      return $ipaddress;
 }