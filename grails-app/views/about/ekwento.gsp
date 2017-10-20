<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
	<head>
		<title>About | e-Kwento - MMM</title>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name='layout' content='main' />
		<style>
			.popover-content{
				color:#000;
			}
			ul li div{
				color:#000;
				font-size:1.5em;
			}
		</style>

		<script>
			$(document).ready(function(){
			$('[data-toggle="popover"]').popover();
			});
		</script>
	</head>
	<body>


		<section id="bulletin" class="hris-section">
            <div class="container bookSection" id="offset-top">
				<div class="leftSidePanel" id="offset-top" style="width:100%">
					<div class="leftSideBooks" style="border-radius:5px;background-color: rgba(189, 184, 184, 0.54);">
						<h2><b>About eKwento</b></h2>
						<p>E-kwento is a web-based mobile application for everyone who loves to read and write. It will benefit the aspiring writers through posting and getting feedback among the viewers to improve and also it will be less hassle to the readers because they can bring wherever they want to go.</p>
						<h4><b>Our Team</b></h4>
                        <p>E-kwento is an online reading application where everyone can read and create their own stories on genres that they prefer.</p>

						<div>
							<ul id="Grid">
								<li>
									<a data-toggle="popover" data-placement="bottom" title="Popover Header" data-content="Some content inside the popover">
										<g:img dir="images" file="ek1.jpg" width="215" height="215"/>
									</a>
									<div>Team 1</div>
								</li>
								<li>
									<a data-toggle="popover" data-placement="bottom" title="Popover Header" data-content="Some content inside the popover">
										<g:img dir="images" file="ek2.jpg" width="215" height="215"/>
									</a>
									<div>Team 2</div>
								</li>
								<li>
									<a data-toggle="popover" data-placement="bottom" title="Popover Header" data-content="Some content inside the popover">
										<g:img dir="images" file="ek3.jpg" width="215" height="215"/>
									</a>
									<div>Team 3</div>
								</li>
							</ul>
						</div>
					</div>

				</div>
			</div>
		</section>
		
		<g:render template="/layouts/footer"/>
	</body>
</html>
