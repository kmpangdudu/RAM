google.maps.__gjsload__('overlay', '\'use strict\';function xT(a){this.j=a}O(xT,U);$a(xT[H],function(a){"outProjection"!=a&&(a=!!(this.get("offset")&&this.get("projectionTopLeft")&&this.get("projection")&&te(this.get("zoom"))),a==!this.get("outProjection")&&this.set("outProjection",a?this.j:null))});function yT(){}function zT(){var a=this.gm_props_;if(this[On]()){if(this[Mc]()){if(!a.Of&&this.onAdd)this.onAdd();a.Of=!0;this.draw()}}else{if(a.Of)if(this[Xc])this[Xc]();else this[Fb]();a.Of=!1}}function AT(a){a.gm_props_=a.gm_props_||new yT;return a.gm_props_}function BT(a){Tj[J](this);this.na=S(a,zT)}O(BT,Tj);function CT(){}\nCT[H].bm=function(a){var b=a[Ln](),c=AT(a),d=c.wg;c.wg=b;d&&(c=AT(a),(d=c.Ha)&&d[qn](),(d=c.ej)&&d[qn](),a[qn](),a.set("panes",null),a.set("projection",null),Q(c.ba,T[Ab]),c.ba=null,c.mb&&(c.mb.na(),c.mb=null),ks("Ox","-p",a));if(b){c=AT(a);d=c.mb;d||(d=c.mb=new BT(a));Q(c.ba,T[Ab]);var e=c.Ha=c.Ha||new rr,f=b[B];e[p]("zoom",f);e[p]("offset",f);e[p]("center",f,"projectionCenterQ");e[p]("projection",b);e[p]("projectionTopLeft",f);e=c.ej=c.ej||new xT(e);e[p]("zoom",f);e[p]("offset",f);e[p]("projection",\nb);e[p]("projectionTopLeft",f);a[p]("projection",e,"outProjection");a[p]("panes",f);e=S(d,d.Z);c.ba=[T[A](a,"panes_changed",e),T[A](f,"zoom_changed",e),T[A](f,"offset_changed",e),T[A](b,"projection_changed",e),T[A](f,"projectioncenterq_changed",e),T[v](b,"forceredraw",d)];d.Z();b instanceof ph&&(hs(b,"Ox"),js("Ox","-p",a,!!b.ga))}};var DT=new CT;Ih.overlay=function(a){eval(a)};dg("overlay",DT);\n')