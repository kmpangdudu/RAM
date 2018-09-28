<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="12.aspx.cs" Inherits="Web._12" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/12.css" rel="stylesheet" />
            <div id="myContent">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Width="100%" cssclass="fancy fancy-green"  ScrollBars="Auto" UseVerticalStripPlacement="False">
            <cc1:TabPanel runat="server" HeaderText="Map" ID="TabPanelMap">
               <ContentTemplate>

      <iframe id="123" width="100%" height="100%" scrolling="no" src="map.aspx">
      </iframe>

               </ContentTemplate>
            </cc1:TabPanel>
            
            <cc1:TabPanel ID="TabPanelPW" runat="server" HeaderText="Phonw & Web">
            <ContentTemplate>
 <div id="PWwrapper" >
     <div id="t" style="position:relative;"
<%--      <header class="cd-header">
		<div id="cd-logo"><a href="#0"><img src="img/cd-logo.svg" alt="Logo"></a></div>

		<nav class="cd-main-nav">
			<ul>
				<!-- inser more links here -->
				<li><a href="#0">Home</a></li>
				<li><a href="#0">About</a></li>
				<li><a href="#0">Pricing</a></li>
				<li><a href="#0">Gallery</a></li>
				<li><a href="#0">Contact</a></li>
			</ul>
		</nav> <!-- cd-main-nav -->
	</header>--%>
	<main class="cd-main-content">
        <!---  111111111111111111111111111111111111111111111111111111111   ---->
		<div class="cd-fixed-bg cd-bg-1">
			<h1>Distress Services</h1>
		</div> <!-- cd-fixed-bg -->

		<div class="cd-scrolling-bg cd-color-2">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



        <!---  2222222222222222222222222222222222222222222222222222222222222   ---->
		<div class="cd-fixed-bg cd-bg-2">
			<h2>Sexual Health </h2>
		</div> <!-- cd-fixed-bg -->

		<div class="cd-scrolling-bg cd-color-3">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



<!-- 33333333333333333333333333333333333333333333333333333333333333333  -->
		<div class="cd-fixed-bg cd-bg-3">
			<h2>Lesbian, Gay, Bi, Trans & Questioning Services </h2>
		</div> <!-- cd-fixed-bg -->

		<div class="cd-scrolling-bg cd-color-1">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->

<!--  4444444444444444444444444444444444444444444  --->
		<div class="cd-fixed-bg cd-bg-4">
			<h2>Legal Help</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-1">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->


<!--  555555555555555555555555555555555555555555555555555  --->
		<div class="cd-fixed-bg cd-bg-4">
			<h2>Youth Shelters & Homelessness </h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-1">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



<!--  66666666666666666666666666666666666666666666666666  --->
		<div class="cd-fixed-bg cd-bg-2">
			<h2>Housing Help</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-1">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->


<!--  77777777777777777777777777777777777777777777777777777777  --->
		<div class="cd-fixed-bg cd-bg-3">
			<h2>Counselling & Mental Health</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-1">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



<!--  88888888888888888888888888888888888888888888888888888888  --->
		<div class="cd-fixed-bg cd-bg-4">
			<h2>Family Violence Shelters</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-1">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



<!--  99999999999999999999999999999999999999  --->
		<div class="cd-fixed-bg cd-bg-4">
			<h2>Drugs, Alcohol & Gambling</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-1">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->
	</main> <!-- cd-main-content -->
     	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="js/main.js"></script> <!-- Resource jQuery -->
</div>

            </ContentTemplate>
                 </cc1:TabPanel>
            
            <cc1:TabPanel ID="TabPanelShelter" runat="server" HeaderText="Shelter">
            <ContentTemplate>
                <div id="Shelterwrapper" >
                    Shelterwrapper
                </div>
            </ContentTemplate>
            </cc1:TabPanel>

        </cc1:TabContainer>
                </div>
</asp:Content>
