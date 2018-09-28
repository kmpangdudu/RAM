<%@ Page Title="" Language="C#" MasterPageFile="~/RAM.Master" AutoEventWireup="true" CodeBehind="14.aspx.cs" Inherits="Web._14" %>

<%@ Register Src="~/Controls/UCfloatmenu.ascx" TagPrefix="uc1" TagName="UCfloatmenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Controls/UCCategory.ascx" TagPrefix="uc1" TagName="UCCategory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/14.css" rel="stylesheet" />
    <link href="css/style14.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">





    <!--- PW Panel    -------->
    <div id="pwPanel1" class="clspwPanel">
<%--        <asp:UpdatePanel ID="UpdatePanelPW" runat="server">
            <ContentTemplate>--%>

                <div id="PWwrapper">

                    <div id="searchArea" class="clssearch">
                        <fieldset id="searchcity">
                            <legend>Location</legend>
                            <table>
                                <tr>
                                    <td>Province:</td>
                                    <td>
                                        <input id="Text0" type="text" /></td>
                                    <td>City:</td>
                                    <td>
                                        <input id="Text1" type="text" /></td>
                                    <td>
                                        <input id="Button1" type="button" value="go" /></td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>

                </div>
                <main class="cd-main-content">
                    <uc1:UCfloatmenu runat="server" ID="UCfloatmenu" />
                 <%--   <uc1:UCCategory runat="server" ID="UCCategory" />--%>

        <!---  111111111111111111111111111111111111111111111111111111111   ---->
		<div class="cd-fixed-bg cd-bg-1">
			<h1>Distress Services</h1>
		</div> <!-- cd-fixed-bg -->

		<div class="cd-scrolling-bg cd-color-1">
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

		<div class="cd-scrolling-bg cd-color-2">
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

		<div class="cd-scrolling-bg cd-color-3">
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
         <div class="cd-scrolling-bg cd-color-4">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->


<!--  555555555555555555555555555555555555555555555555555  --->
		<div class="cd-fixed-bg cd-bg-5">
			<h2>Youth Shelters & Homelessness </h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-5">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



<!--  66666666666666666666666666666666666666666666666666  --->
		<div class="cd-fixed-bg cd-bg-6">
			<h2>Housing Help</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-6">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->


<!--  77777777777777777777777777777777777777777777777777777777  --->
		<div class="cd-fixed-bg cd-bg-7">
			<h2>Counselling & Mental Health</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-7">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



<!--  88888888888888888888888888888888888888888888888888888888  --->
		<div class="cd-fixed-bg cd-bg-8">
			<h2>Family Violence Shelters</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-8">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->



<!--  99999999999999999999999999999999999999  --->
		<div class="cd-fixed-bg cd-bg-9">
			<h2>Drugs, Alcohol & Gambling</h2>
		</div> <!-- cd-fixed-bg -->
         <div class="cd-scrolling-bg cd-color-9">
			<div class="cd-container">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore incidunt suscipit similique, dolor corrupti cumque qui consectetur autem laborum fuga quas ipsam doloribus sequi, mollitia, repellendus sapiente repudiandae labore rerum amet culpa inventore, modi non. Quo nisi veritatis vitae nam, labore fugit. Inventore culpa iusto, officia exercitationem. Voluptates quibusdam odit odio incidunt consequatur, consectetur aspernatur optio vitae molestias, quas repellendus fugit ullam culpa, eligendi et dignissimos voluptatibus illum? Molestias aliquam nostrum quasi ipsa culpa, iusto explicabo ut error, consequuntur enim temporibus, adipisci tempora voluptate, id consequatur mollitia eveniet blanditiis. Illo quod repellendus alias? Cum rem doloremque adipisci accusantium? Saepe, necessitatibus!
				</p>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->

<!--      footer   footer   footer   footer   footer -->

<div class="cd-scrolling-bg cd-color-footer">
			<div class="cd-container">
                <footer style="height:250px;">
                <div id="fc1" class="fc float-left float-left">column 1</div>
                <div id="fc2" class="fc float-left footer">column 2</div>
                <div id="fc3" class="fc float-left float-right">column 3</div>
                                   </footer>
			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->
	</main>
                <!-- cd-main-content -->
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
                <script src="js/main.js"></script>
                <!-- Resource jQuery -->
                </div>
<%--            </ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
    <!--PW Panel-->
</asp:Content>
