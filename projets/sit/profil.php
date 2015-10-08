<?php
require_once("init_inc.php");
if (!utilisateur_est_connecte()) {
	header("location:connexion.php");
	die();
}
require_once("haut_de_site_inc.php");
require_once("menu_inc.php");

?>

<div class="container">



<p class="affair">Hello <?php echo $_SESSION['utilisateur']['pseudo']; ?></p>

<br/>

<p class="b">Prenom: <?php echo $_SESSION['utilisateur']['prenom']; ?></p>
<p class="b">Nom: <?php echo $_SESSION['utilisateur']['nom']; ?></p>
<p class="b">Email: <?php echo $_SESSION['utilisateur']['email']; ?></p> 
<p class="b">Adresse IP actuelle: <?php echo get_client_ip(); ?></p>

<?php
$id_utilisateur =$_SESSION['utilisateur']['id_utilisateur'];
$do = '<p class="b">'; 
$do .= '<a href=mdp.php?id_utilisateur=' . $id_utilisateur;


$do .= ">Changer de mot de passe</a></p>";
echo $do;
?>	
</div>

