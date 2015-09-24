<?php
/* @var $this SiteController */

$this->pageTitle=Yii::app()->name;

$HomeLink =  Yii::app()->createUrl('/site/index'); 

$baseUrl = Yii::app()->baseUrl; 
$cs = Yii::app()->getClientScript();
$cs->registerScriptFile($baseUrl.'/js/pollForAnswerCall.js');
?>

<script language="javascript" type="text/javascript">
    var js_username = "<?php echo Yii::app()->user->name ?>";
</script>

<!--div class=row>
	<div class="jumbotron col-md-12 jumboheader">
			<div class=row>
				<div class="col-md-3">
					<h2>Hello <?php //echo Yii::app()->user->name; ?></h2>
				</div>
				<div class="col-md-6 alert-warning">
					<h2 style="text-align:center">
						You are talking to <?php //echo strtoupper($visavis->username); ?>
					</h2>
				</div>
			</div>
	</div>
</div-->


<!-- Header -->
<div class=row>
	<div class="jumbotron col-md-12 alert alert-warning jumboHeader">
		<h4  style="text-align:center;"	>Hallo <?php echo strToUpper(Yii::app()->user->name); ?>.
			Wir warten bis <?php echo strtoupper($invitee->username); ?> den Anruf beantwortet
		</h4>
	</div>
</div>

<?php

$this->widget ( 'ext.mediaElement.MediaElementPortlet',
    array ( 
	'id' => 'mediaPlayer',
    //'url' => 'http://mp3.ffh.de/ffhchannels/hqschlager.mp3',
    'url' => $invitee->userMusic->musicLink,	
	// or you can set the model and attributes
    //'model' => $model,
    //'attribute' => 'url'
	// its required and so you have to set correctly
     'mimeType' =>'audio/mp3', 
	 'htmlOptions' => array(
		'id' => 'mediaPlayer',
		'display' => 'none',
		),
    ));	
?>
	<script>
		$(document).ready(function () {
			$(".mejs-container").hide();
		});
	</script>

<!-- Main Showing Textual Information on Invitee-->
<?php if(Yii::app()->getGlobalState('slideShow') !== '1') {
	echo "<div class='row'>
		<div class='jumbotron col-md-12'>
			<div class='row'>
				<div class='well col-md-10 col-md-offset-1'>
					<h4 style='text-align:center;'>
						W&auml;hrend wir warten, wussten Sie das schon &uuml;ber ". strToUpper($invitee->username) ."?
					</h4>
				</div>
			</div>
			<div class=row>";
				echo "<!-- Carousel START-->";
								echo  "								
									<div class='col-md-10 col-md-offset-1 well'>
										<div class='media'>
											<a class='pull-left'>
												<img class='media-object img-circle' style='max-height:240px;' src='images/userImages/user" . $invitee->userID . ".jpg'>
											</a>
												<div class='media-body'>
													<blockquote id='videoRight_infoText'>";
													for ($i = 0; $i < sizeOf($invitee->ownUserStories); $i++) {
													echo "<!--h3 class='media-heading'>Did you know about ".$invitee->username."?</h3-->
													<h4>". strToUpper($invitee->username)." ". $invitee->ownUserStories[$i]->userStory. "</h4>";
													}
													echo "</blockquote>";
											echo "</div>
											</div>
										</div>";
		echo"			<!-- Carousel END-->
			</div>
		</div>
	</div>";
} else {
	echo "<div class='row'>
		<div class='jumbotron col-md-12'>
			<div class='well'>
				<h4>
					W&auml;hrend wir warten, erinnern Sie sich an ... ?
				</h4>
			</div>
			<div class=row>
			<div class='col-md-8 col-md-offset-2 well'>";
				echo "<!-- Carousel START-->";
				    $this->widget(
						'booster.widgets.TbCarousel',
						array(
							'options' => array(
								'interval' => 15000,
							),
							'items' => array(
								array(
									'image' => $invitee->userImages->userImageLink1,
									'caption' => $invitee->userImages->userImageDescription1
								),
								array(
									'image' => $invitee->userImages->userImageLink2,
									'caption' => $invitee->userImages->userImageDescription2
								),
								array(
									'image' => $invitee->userImages->userImageLink3,
									'caption' => $invitee->userImages->userImageDescription3
								),
							),
						)
					);
		echo"			<!-- Carousel END-->
				</div>
			</div>
		</div>
	</div>";
}
?>	
	<!-- START OF Answer Modal -->
	<div class="modal fade" id="answerModal">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Anruf beantwortet</h4>
		  </div>
		  <div class="modal-body">
			<p id="answerText"><?php echo strToUpper($invitee->username); ?> hat Ihren Anruf beantwortet und wartet auf Sie</p>
		  </div>
		  <div class="modal-footer">
			<!--a id="cancelCallButton" href="<?php //echo Yii::app()->createUrl('site/index'); ?>" id="rejectButton" type="button" class="btn btn-cancel" data-dismiss="modal">Abbrechen und zur&uuml;ck</a-->
			<a id="goToCallButton" href="<?php echo Yii::app()->createUrl('call/room', array('host'=> $notification->inviterID, 'guest' => $notification->userID)); ?>" id="answerButton" type="submit" class="btn btn-primary">Zum Telefonat</a>
			<input id="hidden_notificationID" value="<?php echo $notification->notID; ?>" type=hidden />
		  </div>
		</div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- END OF Answer Modal -->
	
	<!-- START OF Reject Modal -->
	<div class="modal fade" id="rejectModal">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Anruf abgewiesen</h4>
		  </div>
		  <div class="modal-body">
			<p id="rejectText"> <?php echo strToUpper($invitee->username); ?> hat Ihren Anruf abgewiesen.</p>
		  </div>
		  <div class="modal-footer">
			<a id="goBackButton" href="<?php echo Yii::app()->createUrl('site/index'); ?>" type="submit" class="btn btn-primary">OK, zurück zum Start</a>
			<input value="<?php echo $notification->notID; ?>" id="hidden_notificationID" type=hidden />			
		  </div>
		</div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- END OF Invitation Modal -->

	<!-- START OF No Answer Modal -->
	<div class="modal fade" id="noAnswerModal">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Anruf wurde nicht beantwortet</h4>
		  </div>
		  <div class="modal-body">
			<p id="rejectText"> <?php echo $invitee->username; ?> antwortet nicht.</p>
		  </div>
		  <div class="modal-footer">
			<a id="goBackButton" href="<?php echo Yii::app()->createUrl('site/index'); ?>" type="submit" class="btn btn-primary">OK, zurück zum Start</a>
			<input value="<?php echo $notification->notID; ?>" id="hidden_notificationID" type=hidden />			
		  </div>
		</div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- END OF NoAnswer Modal -->

<!-- Footer -->
<!--div class=row>
		<div class="jumbotron col-md-12 _col-md-offset-1">
			<div class="col-md-4 col-md-offset-4">
			<!--TODO: replace hard-coded logout-->
				<!--a href='<?php //echo //$HomeLink; ?>';">Hang Up!&nbsp;<span style="cursor:pointer" class="glyphicon glyphicon-log-out" alt="Bye!"></span></a>
			</div>
		</div>
</div-->	