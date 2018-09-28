<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Squad.Default" %>

<%@ Register Src="~/Controls/Floatmenu.ascx" TagPrefix="uc1" TagName="Floatmenu" %>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">

    <!-- Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css/animate.css" rel="stylesheet" />
    <!-- Squad theme CSS -->
    <link href="css/style.css" rel="stylesheet">
    <link href="color/default.css" rel="stylesheet">


    <title>Resource Around Me</title>
    <meta name="viewport" content="width=device-width" />
    <meta charset="utf-8" />
    <link href="http://kidshelpphone.ca/favicon.ico" type="image/x-icon" rel="shortcut icon" />
    <link href="http://kidshelpphone.ca/favicon.ico" type="image/x-icon" rel="icon" />
    <link href="../Content/squad.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/reset.css">
    <!-- CSS reset -->

    <link rel="stylesheet" href="css/style.css">
    <!-- Resource style -->
    <link href='http://fonts.googleapis.com/css?family=Oswald:400,300,700|Open+Sans+Condensed:700,300,300italic|Open+Sans:400,300italic,400italic,600,600italic,700,700italic,800,800italic|PT+Sans:400,400italic,700,700italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css' />
    <script src="https://maps.googleapis.com/maps/api/js?v=3.20&signed_in=true&libraries=places"></script>

    <script src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclusterer/src/markerclusterer.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.8.2.min.js"></script>

    <script src="../js/modernizr.js"></script>
    <script src="js/map_squad.js"></script>

</head>
<body id="page-top" data-spy="scroll" data-target=".navbar-custom" style="height:700px!important;">

    <!-- Preloader -->
    <div id="preloader">
        <div id="load"></div>
    </div>

    <nav class="navbar navbar-custom navbar-fixed-top top-nav-collapse" role="navigation" style="padding: 0; background-color: #FFF;">

        <%--        <div id="toptop" class=" float-right" ; style="height:30px; margin-right:5%;border:1px solid blue;width:260px;">
            <ul class="nav navbar-nav">
                <li><a href="http://www.kidshelpphone.ca" >Home</a></li>
                <li><a href="http://jeunessejecoute.ca/resourcesaroundme/?lang=fr">French</a></li>
                <li><a href="http://www.google.com"><img src="../Images/leavel.png" /></a></li>
            </ul>
        </div>--%>

        <div class="container" style="margin-bottom: 3px; width: 1400px; /*border: 1px solid red; */">
            <!--  blue -->
            <div class="navbar-header page-scroll togglewidth">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="https://kidshelpphone.ca/Teens/PhoneUs.aspx">

                    <div style="width: 123px">
                        <img src="../Images/en/khp-logo.gif" style="max-width: 100%;" />
                    </div>
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-right navbar-main-collapse"
                style="width: 1185px; /*border: 1px solid blue; */float: left!important; left: 150px">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="https://kidshelpphone.ca/Teens/PhoneUs.aspx">
                        <img src="../Images/en/nav-phone.png" alt="Phone Us" /></a></li>
                    <li><a href="https://kidshelpphone.ca/Teens/AskUsOnline.aspx">
                        <img src="../Images/en/nav-ask.png" alt="Ask Us" /></a></li>
                    <li><a href="https://kidshelpphone.ca/Teens/InfoBooth.aspx">
                        <img src="../Images/en/nav-info.png" alt="info Booth" /></a></li>
                    <li><a href="https://kidshelpphone.ca/Teens/YourSpace.aspx">
                        <img src="../Images/en/nav-space.png" alt="Your Space" style="margin-top: -5px;" /></a></li>
                    <li><a href="https://kidshelpphone.ca/Teens/GetInvolved.aspx">
                        <img src="../Images/en/nav-involved.png" alt="Get Involved" /></a></li>
                    <!--<li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Example menu</a></li>
                            <li><a href="#">Example menu</a></li>
                            <li><a href="#">Example menu</a></li>
                        </ul>
                    </li>-->
                    <li>
                        <ul class="nav navbar-nav" style="margin-top: -22px;">
                            <li><a href="http://www.kidshelpphone.ca" style="padding: 0 5px;">Home</a></li>
                            <li><a href="http://jeunessejecoute.ca/resourcesaroundme/?lang=fr" style="padding: 0 5px;">French</a></li>
                            <li><a href="http://www.google.com" style="padding: 0 5px;">
                                <img src="../Images/leavel.png" /></a></li>
                        </ul>
                    </li>
                </ul>
            </div>

            <!-- /.navbar-collapse -->
        </div>

        <!-- /.container -->


    </nav>




    <!-- Section: intro -->
    <section id="intro" class="intro">
        <div id="midnav" class="text-center" style="width: 100%; padding: 2px; text-align: center; height: 130px; background-color: #e3e3e3; vertical-align: baseline; /*border: 1px solid #0000ff; */">

            <div id="midnavcontainer" class="text-center" style="width: 100%; text-align: center; margin: 0 auto;">
                <div id="cityseeker" class="float-left" style="padding: 27px 0 0 0;">
                    <input id="pac-input" class="controls" type="text"
                        style="position: absolute; width: 240px; height: 45px; left: 25px; box-shadow: -5px -5px 10px #555555; border-radius: 5px;"
                        placeholder="Enter a city"
                        autofocus title="Type city name,select from below list.">
                    <p>select a city </p>
                </div>
                <div id="myChoice">

                    <div id="Distress" class="filterdiv  float-left oneline b2bfilter" style="left: 300px">
                        <img id="DistressServices" src="../Images/DistressServices.jpg" alt="Distress" class="filterimg" />
                        <p>
                            <img src="../Images/Distress.png" /><input class="b2bfilter" type="checkbox" checked id="1box" value="1"><span class="b2bfiltertext">Distress</span>
                        </p>
                    </div>
                    <div id="Sexual" class="filterdiv float-left oneline b2bfilter" style="left: 430px">
                        <img id="SexualServices" src="../Images/SexualHealth.jpg" alt="SexualServices" class="filterimg" />
                        <p>
                            <img src="../Images/Sexual Health.png" /><input class="b2bfilter" type="checkbox" id="2box" checked value="2"><span class="b2bfiltertext">Sexual Health</span>
                        </p>
                    </div>
                    <div id="LGBT" class="filterdiv float-left oneline b2bfilter" style="left: 550px">
                        <img id="LGBTServices" src="../Images/LGBT.jpg" alt="LGBTServices" class="filterimg" />
                        <p>
                            <img src="../Images/LGBT.png" /><input class="b2bfilter" type="checkbox" id="3box" checked value="3"><span class="b2bfiltertext">LGBT</span>
                        </p>
                    </div>
                    <div id="Legal" class="filterdiv float-left oneline b2bfilter" style="left: 690px">
                        <img id="legalServices" src="../Images/legalHelp.jpg" alt="LegalServices" class="filterimg" />
                        <p>
                            <img src="../Images/Legal Help.png" /><input class="b2bfilter" type="checkbox" id="4box" checked value="4"><span class="b2bfiltertext">Legal Help</span>
                        </p>
                    </div>
                    <div id="Shelters" class="filterdiv float-left oneline b2bfilter" style="left: 800px">
                        <img id="shelterServices" src="../Images/shelter.png" alt="Shelter Services" class="filterimg" />
                        <p>
                            <img src="../Images/Youth Shelters.png" /><input class="b2bfilter" type="checkbox" id="5box" checked value="5"><span class="b2bfiltertext">Youth Shelters</span>
                        </p>
                    </div>
                    <div id="Housing" class="filterdiv float-left oneline b2bfilter" style="left: 940px">
                        <img id="housingHelpServices" src="../Images/housingHelp.jpg" alt="Housing Help Services" class="filterimg" />
                        <p>
                            <img src="../Images/Housing Help.png" /><input class="b2bfilter" type="checkbox" id="6box" checked value="6"><span class="b2bfiltertext">Housing Help</span>
                        </p>
                    </div>
                    <div id="Counselling" class="filterdiv float-left oneline b2bfilter" style="left: 1095px">
                        <img id="counsellingServices" src="../Images/counselling.jpg" alt="Counselling Services" class="filterimg" />
                        <p>
                            <img src="../Images/Counselling.png" /><input class="b2bfilter" type="checkbox" id="7box" checked value="7"><span class="b2bfiltertext">Counselling</span>
                        </p>
                    </div>
                    <div id="Violence" class="filterdiv float-left oneline b2bfilter" style="left: 1280px">
                        <img id="familyViolenceServices" src="../Images/familyViolence.jpg" alt="Family Violence" class="filterimg" />
                        <p>
                            <img src="../Images/Family Violence Shelters.png" /><input class="b2bfilter" type="checkbox" id="8box" checked value="8"><span class="b2bfiltertext">Family Violence Shelters</span>
                        </p>
                    </div>
                    <div id="Drugs" class="filterdiv float-left oneline b2bfilter" style="left: 1460px">
                        <img id="DrugServices" src="../Images/Drug.jpg" alt="Drug Services" class="filterimg" />
                        <p>
                            <img src="../Images/Drugs, Alcohol and Gambling.png" /><input class="b2bfilter" type="checkbox" id="9box" checked value="9"><span class="b2bfiltertext">Drugs, Alcohol and Gambling</span>
                        </p>
                    </div>

                </div>


            </div>

        </div>
        <div style="clear: both;"></div>

        <div id="MapCanvas"></div>

    </section>
    <!-- /Section: intro -->



   





    <!-- Section: Phone and Web -->
    <section id="pwintro" class="parallax height350" style="margin-top: 120px">
        <!--<div class="container">-->
        <!--<div class="row">-->
        <div class="slogan">
            <h2>Weclome to <span class="text_color">Kids Help Phone</span> </h2>
            <h4>Every day, hundreds of kids reach out to Kids Help Phone during their most challenging and critical moments.</h4>
        </div>
        <div class="page-scroll">
            <a href="#phoneWeb" class="btn btn-circle">
                <i class="fa fa-angle-double-down animated"></i>
            </a>
        </div>
        <!--</div>-->
        <!--</div>-->
    </section>

    <form id="form1" runat="server">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

         <uc1:Floatmenu runat="server" ID="Floatmenu" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <section id="phoneWeb" class="home-section text-center  ">

                    <div class="heading-about">
                        <div class="container" style="width: 100%!important;">
                            <div class="row">
                                <div class="col-lg-8 col-lg-offset-2">
                                    <div class="wow bounceInDown" data-wow-delay="0.4s">
                                        <div class="section-heading">
                                            <h2>Phone and Web</h2>
                                            <div id="pwSearch" class="pwsearch">
                                                Province:
                                                <asp:DropDownList ID="ddlProvince" runat="server"
                                                    AutoPostBack="True"
                                                    CssClass="provinceWidth"
                                                    OnSelectedIndexChanged="ddlProvince_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                City:&nbsp;
                                                <asp:DropDownList ID="ddlCity" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged" CssClass="cityWidth"></asp:DropDownList>

                                                <div id="pwSearchResult" class="pwsearch">
                                                    Total of Resource:&nbsp;
                                                <asp:Label ID="lblPWTotalNum" runat="server" Text="Label"> </asp:Label>
                                                </div>
                                            </div>

                                            <i class="fa fa-2x fa-angle-down"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">


                        <!-- 111 -->
                        <asp:Panel ID="PanelDistress" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow bounceInUp div-box-shadow div-border-radius" data-wow-delay="0.2s">
                                <div class="team boxed-grey div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/service-icon-1.png" alt="" class="width_35px" />
                                            1 Distress Services</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">

                                            <asp:GridView ID="gvpwDistress" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkDistress" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnDistress" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lblDistressNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwDistressmore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!-- 222 -->
                        <asp:Panel ID="PanelSexual" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">

                            <div class="wow bounceInUp div-box-shadow div-border-radius" data-wow-delay="0.5s">
                                <div class="team boxed-grey div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/Sexual.png" alt="" class="width_35px" />
                                            2 Sexual Health</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">

                                            <asp:GridView ID="gvpwSexual" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkSexual" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnSexual" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lblSexualNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwSexualmore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!-- 333 -->
                        <asp:Panel ID="Panellgbt" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">

                            <div class="wow bounceInUp div-box-shadow div-border-radius" data-wow-delay="0.8s">
                                <div class="team boxed-grey div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/LGBT.png" alt="" class="width_35px" />
                                            3 LGBT</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">

                                            <asp:GridView ID="gvpwlgbt" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnklgbt" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnlgbt" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lbllgbtNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwlgbtmore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!-- 444 -->
                        <asp:Panel ID="PanelLegal" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow bounceInUp div-box-shadow div-border-radius" data-wow-delay="1s">
                                <div class="team boxed-grey div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/Legal.png" alt="" class="width_35px" />
                                            4 Legal Help</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">
                                            <asp:GridView ID="gvpwLegal" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkLegal" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnLegal" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>

                                        </div>
                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lblLegalNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwLegalmore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!-- 555 -->
                        <asp:Panel ID="PanelShelters" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow bounceInUp div-box-shadow div-border-radius" data-wow-delay="0.2s">
                                <div class="team boxed-grey  div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/Shelter.png" alt="" class="width_35px" />
                                            5 Youth Shelters & Homelessness </h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">
                                            <asp:GridView ID="gvpwShelters" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkShelters" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnShelters" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lblSheltersNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwSheltersmore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!-- 666 -->
                        <asp:Panel ID="PanelHousing" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow bounceInUp  div-box-shadow div-border-radius" data-wow-delay="0.5s">
                                <div class="team boxed-grey  div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/house.png" alt="Housing help" class="width_35px" />
                                            6Housing Help</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">
                                            <asp:GridView ID="gvpwHousing" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkHousing" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnHousing" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>

                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lblHousingNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwhousemore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!-- 777 -->
                        <asp:Panel ID="PanelCounselling" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow bounceInUp div-box-shadow div-border-radius" data-wow-delay="0.8s">
                                <div class="team boxed-grey  div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/Counselling.png" alt="Counselling" class="width_35px" />
                                            7 Counselling & Mental Health</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">
                                            <asp:GridView ID="gvpwCounselling" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkCounselling" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnCounselling" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>

                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lblCounsellingNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwCounsellingmore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!-- 888 -->
                        <asp:Panel ID="PanelViolence" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow bounceInUp  div-box-shadow div-border-radius" data-wow-delay="1s">
                                <div class="team boxed-grey div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/Counselling.png" alt="Family Violence" class="width_35px" />
                                            8 Family Violence Shelters</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">
                                            <asp:GridView ID="gvpwViolence" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkViolence" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnViolence" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>

                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;<asp:Label ID="lblViolenceNum" runat="server" Text="Label"></asp:Label>
                                        <%--<asp:LinkButton ID="lbtnpwViolencemore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>


                        <!-- 999 -->
                        <asp:Panel ID="PanelDrugs" runat="server" CssClass="col-xs-6 col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow bounceInUp  div-box-shadow div-border-radius" data-wow-delay="0.2s">
                                <div class="team boxed-grey div-border-radius">
                                    <div class="inner">
                                        <h5>
                                            <img src="img/icons/drugalcohol.gif" alt="" class="width_35px" />
                                            9 Drugs, Alcohol & Gambling</h5>
                                        <p class="subtitle"></p>
                                        <div class="avatar marge-bottom-5 min-height">
                                            <asp:GridView ID="gvpwDrugs" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" OnRowCommand="gvpwDrugs_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <ul id="divlnkDrugs" class="lnkbtn">
                                                                <li>
                                                                    <asp:LinkButton ID="lbtnDrugs" runat="server"
                                                                        Text='<%# Eval("PublicName")%>'
                                                                        ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                        CommandName="Select"
                                                                        CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="textalign">
                                        Resources:&nbsp;
                                        <asp:Label ID="lblDrugsNum" runat="server"></asp:Label>
                                        <%-- <asp:LinkButton ID="lbtnpwDrugsMore" runat="server" Enabled="false">more...</asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                </section>
                <!-- /Section: Phone and Web -->



                <!-- Section: Shelter -->


                <section id="shelterintro" class="parallax  height350">


                    <div class="slogan">
                        <h2>Kids Need<span class="text_color">Kids Help Phone</span> </h2>
                        <h4>Now more than ever, kids need Kids Help Phone. Our professional counsellors are continually in touch with young people from across the country.</h4>
                    </div>
                    <div class="page-scroll">
                        <a href="#shelter" class="btn btn-circle">
                            <i class="fa fa-angle-double-down animated"></i>
                        </a>
                    </div>
                </section>


                <section id="shelter" class="home-section text-center   ">

                    <div class="heading-about">
                        <div class="container" style="width: 100%!important;">
                            <div class="row">
                                <div class="col-lg-8 col-lg-offset-2 ">
                                    <div class="wow bounceInDown" data-wow-delay="0.4s">
                                        <div class="section-heading">
                                            <h2>Shelter</h2>
                                            <div id="shelterSearch" class="pwsearch">
                                                Province:&nbsp;
                                                <asp:DropDownList ID="ddlProvince_S" runat="server" AutoPostBack="True"
                                                    OnSelectedIndexChanged="ddlProvince_S_SelectedIndexChanged"
                                                    CssClass="provinceWidth">
                                                </asp:DropDownList>
                                                City:&nbsp;
                                                <asp:DropDownList ID="ddlCity_S" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCity_S_SelectedIndexChanged" CssClass="cityWidth"></asp:DropDownList>


                                                <div id="shelterSearchResult" class="pwsearch">
                                                    Total of Resource:&nbsp;
                                                    <asp:Label ID="lblShelterTotalNum" runat="server" Text="Label">(placeholder)</asp:Label>
                                                </div>
                                            </div>
                                            <i class="fa fa-2x fa-angle-down"></i>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">




                        <!-- 1 -->
                        <asp:Panel ID="Panel_S_Distress" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInLeft" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/service-icon-1.png" alt="" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Distress Services</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Distress" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnDistressS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_DistressNum" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 2 -->
                        <asp:Panel ID="Panel_S_Sexual" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInUp" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/Sexual.png" alt="" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Sexual Health</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Sexual" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn  padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnSexualS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_SexualNum" runat="server"></asp:Label>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 3 -->
                        <asp:Panel ID="Panel_S_lgbt" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInUp" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/LGBT.png" alt="" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>LGBT</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_LGBT" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnLGBTS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_LGBT_Num" runat="server"></asp:Label>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 4 -->
                        <asp:Panel ID="Panel_S_Legal" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInRight" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/Legal.png" alt="Legal Help" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Legal Help</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Legal" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnLegalS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_Legal_Num" runat="server"></asp:Label>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 5 -->
                        <asp:Panel ID="Panel_S_Shelters" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInLeft" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/shelter.png" alt="Youth Shelter" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Youth Shelters & Homelessness </h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Shelters" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnSheltersS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                            </div>
                                            <div class="textalign-s">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_Shelters_Num" runat="server"></asp:Label>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 6 --->
                        <asp:Panel ID="Panel_S_Housing" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInUp" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/house.png" alt="Housing Help" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Housing Help</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Housing" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnHousingS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_Housing_Num" runat="server"></asp:Label>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 7 -->
                        <asp:Panel ID="Panel_S_Counselling" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInUp" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/Counselling.png" alt="Counselling" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Counselling & Mental Health</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Counselling" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnCounsellingS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_Counselling_Num" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 8 -->
                        <asp:Panel ID="Panel_S_Violence" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInRight" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/Counselling.png" alt="" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Family Violence Shelters</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Violence" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDistress_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnViolenceS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_Violence_Num" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                        <!-- 9 -->
                        <asp:Panel ID="Panel_S_Drugs" runat="server" CssClass="col-sm-3 col-md-3 col-l-3 marge-bottom-5">
                            <div class="wow fadeInLeft" data-wow-delay="0.2s">
                                <div class="service-box">
                                    <div class="service-icon">
                                        <img src="img/icons/drugalcohol.gif" alt="" class="width_50px" />
                                    </div>
                                    <div class="service-desc">
                                        <h5>Drugs, Alcohol & Gambling</h5>
                                        <p>Vestibulum tincidunt enim in pharetra malesuada. Duis semper magna metus electram accommodare.</p>
                                        <div class="avatar marge-bottom-5 min-height-s  div-border-radius div-box-shadow">
                                            <div class="innerBox">
                                                <asp:GridView ID="gv_S_Drugs" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <ul id="divlnkDrugs_S" class="lnkbtn padding-left30">
                                                                    <li>
                                                                        <asp:LinkButton ID="lbtnDrugsS" runat="server"
                                                                            Text='<%# Eval("PublicName")%>'
                                                                            ToolTip='<%# Eval ("AgencyDescription")%>'
                                                                            CommandArgument='<%# Eval("ETLLoadID")%>'></asp:LinkButton></li>
                                                                </ul>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="textalign">
                                                Resources:&nbsp;
                                                <asp:Label ID="lbl_S_Drugs_Num" runat="server"></asp:Label>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </asp:Panel>

                    </div>

                </section>
                <!-- /Section: Shelter -->
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>


    <!-- Section: footer -->
    <section id="footerintro" class="parallax  height350 ">


        <div class="slogan">
            <h2>Have you ever contacted <span class="text_color">Kids Help Phone</span> with a problem or concern?</h2>
            <h4>We are looking for individuals 25 years old or over who want to share their story about how Kids Help Phone helped them when they were kids.</h4>
        </div>

    </section>


    <!-- /Section: footer -->

    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="wow shake" data-wow-delay="0.4s">
                        <div class="page-scroll marginbot-30">
                            <a href="#page-top" id="totop" class="btn btn-circle">
                                <i class="fa fa-angle-double-up animated"></i>
                            </a>
                        </div>
                    </div>
                    <div style="float:left; width:100% ">
                        <!-- 1st column -->
                        <div class="col-xs-6 col-sm-4 col-md-4 col-l-4 marge-bottom-5" style="float: left;">
                            <div class="wow bounceInUp  div-border-radius" data-wow-delay="0.8s">
                                <div class="team  div-border-radius" style="text-align:left;">
                                   <%-- <div class="inner">--%>
                                        <h5>Get Involved</h5>
                                    <div class="avatar  ">
                                        Lorem ipsum dolor sit amet,CDone,                                       
                                    </div>
                                    <div class="avatar   ">
                                        consectetuer adipiscing elitt
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                  <%--  </div>--%>

                                </div>
                            </div>
                        </div>
                        <!-- 2nd column  -->
                        <div class="col-xs-6 col-sm-4 col-md-4 col-l-4 marge-bottom-5" style="  float: left">
                            <div class="wow bounceInUp div-border-radius" data-wow-delay="0.8s">
                                <div class="team  div-border-radius" style="text-align:left;">
                                  
                                        <h5>Volunteer with KHP</h5>

                                     <div class="avatar  ">
                                        Lorem ipsum dolor sit amet,CDone,                                       
                                    </div>
                                    <div class="avatar   ">
                                        consectetuer adipiscing elitt
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                    <div class="avatar  ">
                                        ascetur ridiculus mus.,
                                    </div>
                                     

                                </div>
                            </div>
                        </div>

                       <!-- 4th column -->


                        <div class="col-xs-6 col-sm-4 col-md-4 col-l-4 marge-bottom-5"  >
                            <div class="wow bounceInUp div-border-radius" data-wow-delay="0.8s">
                                <div class="team   div-border-radius" style="text-align:left;">
                                    <div class="inner">
                                        <h5>About Us</h5>

                                    <div class="avatar  ">
                                        How Kids Use Our Service                                       
                                    </div>
                                    <div class="avatar   ">
                                        Kids Need Kids Help Phone
                                    </div>
                                    <div class="avatar  ">
                                        Our Mission
                                    </div>
                                    <div class="avatar  ">
                                        Publications
                                    </div>
                                    <div class="avatar  ">
                                        Board of Directors
                                    </div>
                                    <div class="avatar  ">
                                        Leadership
                                    </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>



                        <!-- 3rd column -->


                        <div class="col-xs-6 col-sm-4 col-md-4 col-l-4 marge-bottom-5"  >
                            <div class="wow bounceInUp div-border-radius" data-wow-delay="0.8s">
                                <div class="team   div-border-radius" style="text-align:left;">
                                    <div class="inner">
                                        <h5>About Us</h5>

                                    <div class="avatar  ">
                                        How Kids Use Our Service                                       
                                    </div>
                                    <div class="avatar   ">
                                        Kids Need Kids Help Phone
                                    </div>
                                    <div class="avatar  ">
                                        Our Mission
                                    </div>
                                    <div class="avatar  ">
                                        Publications
                                    </div>
                                    <div class="avatar  ">
                                        Board of Directors
                                    </div>
                                    <div class="avatar  ">
                                        Leadership
                                    </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="clear:both;border-top:1px solid #999; padding-top:15px;" />
                    <div style="float:left;width:25%;text-align:left; padding-left:15px"> <p>&copy;Copyright 2015 - KHP. All rights reserved.</p></div>
                    <div style="float:left;width:25%;text-align:left;"><p>Charitable Reg # 13000 5846 RR0001.</p></div>
                    <div style="float:left;width:25%;font-size:70%;text-align:left;"> <a href="#"> Privacy Policy </a></div>
                    <div style="float:left;width:25%;font-size:70%;text-align:left;"> <a href="#"> Terms of Use</a></div>
                    
                </div>
            </div>
        </div>
    </footer>

    <!-- Core JavaScript Files -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.min.js"></script>
    <script src="js/jquery.scrollTo.js"></script>
    <script src="js/wow.min.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="js/custom.js"></script>

</body>
</html>
