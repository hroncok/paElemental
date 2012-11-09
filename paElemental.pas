program paElemental;

{
        paElemental.pas
        
        (c) 2007 by Miro "churchyard" Hrončok, jr. <churchyard@gmail.com>
        
        Soubor uložen v kódování UTF-8.
        
        Tento program je svobodný software. Můžete jej dále distribuovat
        a/nebo upravovat pod podmínkami licence GNU General Public License
        vydané organizací Free Software Foundation, verze licence 2 nebo
        vyšší (dle Vaší volby). 
        
        Tento program je distribuován v naději, že bude užitečným, ale
        NEPOSKYTUJE ŽÁDNÉ ZÁRUKY. Bez jakékoli vyplývající záruky na
        OBCHODOVATELNOST nebo VHODNOST PRO KONKRÉTNÍ POUŽITÍ. Pro více
        podrobností si přečtěte licenci GNU General Public Licence.
        
        http://www.gnu.org/copyleft/gpl.html
        
}

uses crt;
const
	{ *** CHEMIE *** }
	MaxPrvku		= {1}18;	{ prvku je 118, tento program funguje jen jako engine }
						{ ziskavani informaci o vsech prvkach by byl namet na rocnikovou praci z chemie }
						{ proto funkcnost ukazuji jen na 18 z nich (1. tri radky PTP) }

	{ *** NASTAVENI *** }
	EndDelay		= 350; { kolik ms pockat pred koncem }

	{ *** PROGRAM *** }
	programName		= 'paElemental';
	version			= '1.02';
	copyright		= '(c) 2007 by churchyard';

	{ *** GEOMETRIE *** }
	RozliseniX		= 80;
	RozliseniY		= 24;

	VyskaCaraMenu		= 7;
	VrsekCarMenu		= RozliseniY-7;
	ZacatekCarMenu		= 7;
	KonecCarMenu		= 41;

	copyrightX		= 57;
	copyrightY		= RozliseniY-1;

	versionX		= 3;
	versionY		= 2;

	znackaX			= RozliseniX-12;
	znackaY			= 2;

	nazevX			= 23; { pouzije se pro vic veci }
	nazevY			= 5;
	protonovecY		= nazevY+1;
	radioaktivniY		= protonovecY+1;
	elektronegY		= radioaktivniY+1;
	izotopyY		= elektronegY+1;

	latinaX			= 47; { pouzije se pro vic veci }
	latinaY			= nazevY;
	oxidacnicY		= protonovecY;
	molarni_hY		= radioaktivniY;

	umisteniX		= 4;
	umisteniY		= 12;

	valencniX		= umisteniX;
	valencniY		= 14;

	skupenstviX		= 48; { pouzije se pro vic veci }
	skupenstviY		= RozliseniY-10;

	latkaY			= skupenstviY+1;
	hustotaY		= latkaY+1;

	textyX			= 48;
	text1Y			= 19;
	text2Y			= text1Y+1;
	text3Y			= text2Y+1;

	BankyX			= 3;
	BankyY			= 3;

	MenuVsechnoX		= 11;

	MenuNovyY		= RozliseniY-6;
	MenuHlMenuY		= RozliseniY-4;
	MenuAboutY		= RozliseniY-3;
	MenuKonecY		= RozliseniY-1;

	WoknoNahore		= 5;
	WoknoDole		= MenuNovyY-3;
	WoknoVlevo		= 7;
	WoknoVpravo		= RozliseniX-6;

	DotazNahore		= 7;
	DotazDole		= 15;
	DotazVlevo		= 21;
	DotazVpravo		= RozliseniX-20;

	MiniDotazNahore		= 7;
	MiniDotazDole		= 9;
	MiniDotazVlevo		= 7;
	MiniDotazVpravo		= 34;

	InputVlevo		= DotazVlevo+MiniDotazVlevo;
	InputVpravo		= DotazVlevo+MiniDotazVpravo-2;
	InputY			= DotazNahore+MiniDotazNahore;

	InstrukceX		= 4;
	InstrukceYa		= 3;
	InstrukceYb		= 5;

	{ *** LANG *** }
	LangMenuNovy		= 'Hledat novy prvek          N';
	LangMenuHlMenu		= 'Hlavni pokec               O';
	LangMenuAbout		= 'O programu...              A';
	LangMenuKonec		= 'Konec programu             Q';

	LangNazev		= 'Nazev:';
	LangProtonoveC		= 'Protonove c.:';
	LangRadioaktivni	= 'Radioaktivni:';
	LangElektroneg		= 'Elektronegativita:';
	LangIzotopy		= 'Stab. izotopy:';

	LangLatina		= 'Latinsky:';
	LangOxidacniC		= 'Oxidacni c.:';
	LangMolarniH		= 'Molarni hmotnost:';

	LangUmisteniPTP		= 'Umisteni v PTP:';
	LangRadek		= 'radek';

	LangValencni		= 'Valencni vrstva:';

	LangSkupenstvi		= 'Skupenstvi:';
	LangLatka		= 'Latka:';
	LangHustota		= 'Hustota:';

	LangOKterem		= ' O kterem prvku chces vedet vic ? ';
	LangHackyCarky		= 'Zadavej, prosim, bez hacku a carek';
	LangNemam		= '        Tak tohle tu nemam        ';
	LangJen18		= ' Pozor - mam jen prvnich 18 prvku ';

	{ *** MENU *** }
	{ klavesy: }
	KeyUp			= chr(72);
	KeyDown			= chr(80);
	KeyEnter		= chr(13);
	KeySpace		= chr(32);
	KeyEsc			= chr(27);
	Key_n			= chr(110);	{ male  n }
	KeyN			= chr(78);	{ velke N }
	Key_o			= chr(111);	{ male  o }
	KeyO			= chr(79);	{ velke O }
	Key_a			= chr(97);	{ male  a }
	KeyA			= chr(65);	{ velke A }
	Key_q			= chr(113);	{ male  q }
	KeyQ			= chr(81);	{ velke Q }

	{ souradnice: }
	MenuZacniX		= 9;
	MenuZacniY		= RozliseniY-6;
	MenuNovy		= 0;
	MenuDira2		= 1;
	MenuHlMenu		= 2;
	MenuAbout		= 3;
	MenuDira1		= 4;
	MenuKonec		= 5;

	{ pro zjednoduseni: }
	MenuPosledni		= MenuKonec;
	MenuPrvni		= MenuNovy;
	MenuSkacuO		= MenuPosledni+1;


	{ *** BARVY *** }
	{ normalni: }
	BarvaCerna		= 0;
	BarvaModra		= 1;
	BarvaOlivova		= 2;
	BarvaTyrkys		= 3;
	BarvaRuda		= 4;
	BarvaFialova		= 5;
	BarvaHneda		= 6;
	BarvaBila		= 7;
	{ tucne: }
	Barva2seda		= 8;
	Barva2modra		= 9;
	Barva2zelena		= 10;
	Barva2tyrkys		= 11;
	Barva2cervena		= 12;
	Barva2ruzova		= 13;
	Barva2zluta		= 14;
	Barva2bila		= 15;
	{ pro zjednoduseni: }
	BarvaNative		= BarvaBila;

	pozice: shortint	= 0;
	breakni:Boolean		= FALSE;

type	group			= 11..28; { to je typ s nevyuzityma hodnotama 19 a 20}

type	TPrvek			= record { to zdnalive nevhodne poradi je kvuli tabulce, co pisu v OOo }
					z:		byte;
					znacka,
					jmeno,
					latina,
					oxidcislo:	string;
					radioaktivni:	Boolean;
					molvaha,
					elekneg:	real;
					izotopy:	string;
					sloupec:	group;
					radek:		byte;
					valencni:	string;
					skupenstvi:	char;
					latka:		string;
					hustota:	real;
					text1,
					text2,
					text3:		string;
				  end;

type	TPrvky			= array [1..MaxPrvku] of TPrvek;

var	databaze:		TPrvky;

function AnoNe(Boo:Boolean):string;
begin
	if Boo then AnoNe:='ano' else AnoNe:='ne';
end;

function int2string(cislo:integer):string; { aneb jak si z procedury udelat fci }
begin
	str(cislo,int2string);
end;

function real2string(vstup:real):string; { oreze z realu 0 na konci a do to do stringu }
begin
	str(vstup:0:8,real2string);
	while	real2string[length(real2string)]='0' do		dec(real2string[0]);
	if	real2string[length(real2string)]='.' then	dec(real2string[0]);
	{ nemuzu to dat taky do while cyklu (jako OR) protoze by to sekalo nuly i pred desetinou carkou }
end;

function char2skupenstvi(gls:char):string; { g: plynne (g) etc. }
begin
	case gls of
		'g': char2skupenstvi:='plynne (g)';
		'l': char2skupenstvi:='kapalne (l)';
		's': char2skupenstvi:='pevne (s)';
	end;
end;

function group2string(skupina:group):string; { vyhodnoti z ID skupiny jeji nazev }
begin
	case skupina of
		11: group2string:='I.A (alkalicke kovy)';
		12: group2string:='II.A (kovy alkalickych zemin)';
		13: group2string:='III.A (triely)';
		14: group2string:='IV.A (tetrely)';
		15: group2string:='V.A (pentely)';
		16: group2string:='VI.A (chalkogeny)';
		17: group2string:='VII.A (halogeny)';
		18: group2string:='VIII.A (vzacne plyny)';

		21: group2string:='I.B (kovy)';
		22: group2string:='II.B (kovy)';
		23: group2string:='III.B (kovy)';
		24: group2string:='IV.B (kovy)';
		25: group2string:='V.B (kovy)';
		26: group2string:='VI.B (kovy)';
		27: group2string:='VII.B (kovy)';
		28: group2string:='VIII.B (kovy)';
	end;
end;

{ nacte prvek do databaze }
procedure ZapisPrvek(ZapisID:byte; ZapisZnacka, ZapisJmeno, ZapisLatina, ZapisOxidCislo:string; ZapisRadioaktivni:Boolean; ZapisMolVaha, ZapisElekNeg:real; ZapisIzotopy:string; ZapisSloupec:group; ZapisRadek:byte; ZapisValencni:string; ZapisSkupenstvi:char; ZapisLatka:string; ZapisHustota:real; ZapisTextA, ZapisTextB, ZapisTextC: string);
begin
	with databaze[ZapisID] do
	begin
		z		:=ZapisID;
		znacka		:=ZapisZnacka;
		jmeno		:=ZapisJmeno;
		latina		:=ZapisLatina;
		oxidcislo	:=ZapisOxidCislo;
		radioaktivni	:=ZapisRadioaktivni;
		molvaha		:=ZapisMolVaha;
		elekneg		:=ZapisElekNeg;
		izotopy		:=ZapisIzotopy;
		sloupec		:=ZapisSloupec;
		radek		:=ZapisRadek;
		valencni	:=ZapisValencni;
		skupenstvi	:=ZapisSkupenstvi;
		latka		:=ZapisLatka;
		hustota		:=ZapisHustota;
		text1		:=ZapisTextA;
		text2		:=ZapisTextB;
		text3		:=ZapisTextC;
	end;
end;

procedure ZapisPrvky; { postupne nacte vsecky prvky }
begin
	ZapisPrvek(1,'H','Vodik','Hydrogenium','-I, I',FALSE,1.01,2.2,'1, 2, 3',11,1,'1s1','g','vodik (H2)',0.09,'Nejlehci a nejjednodusi prvek','Prevazna cast hmoty vesmiru','Bez barvy, chuti, zapachu');
	ZapisPrvek(2,'He','Helium','Helium','0',FALSE,4.0026,0.0,'3, 4',18,1,'1s2','g','helium (He)',0.18,'Pri beznem tlaku nikdy nezmrzne','Zcela inertni','Bez barvy, chuti, zapachu');
	ZapisPrvek(3,'Li','Lithium','Lithium','I',FALSE,6.941,0.97,'6, 7',11,2,'2s1','s','oxid lithny (Li2O)',0.179,'Nejlehci z alkalickych kovu',' ','Stribrite leskly');
	ZapisPrvek(4,'Be','Beryllium','Beryllium','II',FALSE,9.01,1.5,'9',12,2,'2s2','s','oxid beryllnaty (BeO)',1.85,'Nejlehci z kovu alk. zemin','Propousti radioaktivni zareni','Tvrdy, sedy kov');
	ZapisPrvek(5,'B','Bor','Borum','-III, III',FALSE,10.81,2.04,'10, 11',13,2,'2s2 2p1','s','oxid bority (Be2O3)',2.34,'Vysoky bod tani i varu',' ','Nejlehci z trielu');
	ZapisPrvek(6,'C','Uhlik','Carboneum','-IV, II, IV',FALSE,12.01,2.5,'20, 21, 22',14,2,'2s2 2p2','s','grafit/diamant',2.267,'Diamant ma hustotu 3.515 g/cm3','Jako diamant nejtvrdsi','       v Mohsove stupnici');
	ZapisPrvek(7,'N','Dusik','Nitrogenium','-III, II, III, IV, V',FALSE,14.01,3.1,'14',15,2,'2s2 2p3','g','dusik (N2)',1.2506,'Hlavni slozka zemske atmosfery','Je inertni','Bez barvy, chuti, zapachu');
	ZapisPrvek(8,'O','Kyslik','Oxygenium','-II',FALSE,15.9994,3.5,'16, 17, 18',16,2,'2s2 2p4','g','kyslik (O2)',1.429,'2. hlavni slozka zem. atmosfery','Nezbytny pro existenci zivota','Bez barvy, chuti, zapachu');
	ZapisPrvek(9,'F','Fluor','Fluorum','-I',FALSE,18.998,4.1,'19',17,2,'2s2 2p5','g','F- (ruzne slouceniny)',1.696,'Nejvetsi elektronegativita','Extremne reaktivni','Nazelenaly plyn, toxicky');
	ZapisPrvek(10,'Ne','Neon','Neon','0',FALSE,20.18,0,'20, 21, 22',18,2,'2s2 2p6','g','neon (ne)',0.8999,'Zcela inertni','Maly el. odpor - osvetlovani','Bez barvy, chuti, zapachu');
	ZapisPrvek(11,'Na','Sodik','Natrium','I',FALSE,22.99,1,'23',11,3,'3s1','s','Na+ (ruzne slouceniny)',0.968,'Lze krajet nozem','Vede proud i teplo','Intenzivne zluty plamen');
	ZapisPrvek(12,'Mg','Horcik','Magnesium','II',FALSE,24.31,1.2,'24',12,3,'3s2','s','Mg2+ (ruzne sluceniny)',1.738,'Redukcni cinidlo','Organicka synteza, pyrotechnika','Lehky, tvrdy, stribroleskly');
	ZapisPrvek(13,'Al','Hlinik','Aluminium','III',FALSE,26.98,1.5,'27',13,3,'3s2 3p1','s','bauxit (Al2O3 . 2 H2O)',2.7,'Dobry vodic','Velmi lehky kov','Belave seda barva');
	ZapisPrvek(14,'Si','Kremik','Silicium','-IV, IV',FALSE,28.09,1.7,'28',14,3,'3s2 3p2','s','Si+4 (ruzne slouceniny)',2.33,'Zemska kura','Tvrdy polokov',' ');
	ZapisPrvek(15,'P','Fosfor','Phosporus','-III, I, III, V',FALSE,30.97,2.1,'31',15,3,'3s2 3p3','s','bily fosfor (P4)',1.823,'Hustota cerveneho: 2.34 g/cm3','Hustota cerneho: 2.69 g/cm3',' ');
	ZapisPrvek(16,'S','Sira','Sulphur','-II, IV, VI',FALSE,32.06,2.4,'32, 33, 34, 36',16,3,'3s2 3p4','s','sira (S8)',2.07,'Vyskytuje se v ruznych formach','   vcetne plasticke',' ');
	ZapisPrvek(17,'Cl','Chlor','Chlorum','-I, III, V, VII',FALSE,35.45,2.8,'35',17,3,'3s2 3p5','g','chlor (Cl2)',0.0032,'Jedovaty plyn','Vysoce reaktivni',' ');
	ZapisPrvek(18,'Ar','Argon','Argon','0',FALSE,39.95,0,'40',18,3,'3s2 3p6','g','argon (Ar)',0.001784,'Nereaktivni','Je inertni','Bez barvy, chuti, zapachu');
end;

procedure VodorovnaCara(sirka:integer; znak:char); { kresli vodorovnou caru ze znaku, nepocita s prekrocenim okna }
var	i:	1..RozliseniX;
begin
	{ vypis znaky }
	for i:=1 to sirka do write(znak);
end;

procedure SvislaCara(vyska:integer; znak:char); { kresli svislou caru ze znaku }
var	sloupec, radek, aktualniRadek: integer;
	i:	1..RozliseniY;
begin

	sloupec := whereX;
	radek   := whereY;

	{ po radcich }
	for i:=1 to vyska do
	begin
		write(znak);
		aktualniRadek:=radek+i;
		gotoXY(1,1); { delalo neporadek na konci radku }
		if i<>vyska then { jestlize neni posledni, skoci o jedno dolu }
			gotoXY(sloupec,aktualniRadek);
	end;

end;

procedure Ramecek(vlevo, nahore, vpravo, dole: integer); { kresli obdelnik ze znaku }
begin

	gotoXY(vlevo,nahore);
	VodorovnaCara(vpravo-vlevo+1,'=');

	gotoXY(vlevo,dole);
	VodorovnaCara(vpravo-vlevo+1, '=');

	gotoXY(vlevo,nahore);
	SvislaCara(dole-nahore+1, '|');

	gotoXY(vpravo,nahore);
	SvislaCara(dole-nahore+1, '|');

end;

{

obe nasledujici procedury jsem vymyslel az potom, co jsem mel nadefinovane konstanty a az velmi pozde, me napadlo, jaka to je blbina.
mnohem programtorovejsi by bylo mit pole recordu:
nazev_pole[cislo].lang ---> string
nazev_pole[cislo].x ---> shortint
nazev_pole[cislo].y ---> shortint

for cislo:=1 to nejake_maximum do
begin
	gotoxy(nazev_pole[cislo].x,nazev_pole[cislo].y);
	write(nazev_pole[cislo].lang);
end;


ale co uz :(
nestihnu to predelat (prave je 29.5.2007)

}

procedure VypisCoKam(VypisCo:string; VypisKamX, VypisKamY: integer); { vypise string na urcitou souradnici }
begin
	gotoXY(VypisKamX,VypisKamY);
	write(VypisCo);
end;

procedure VypisKolikKam(VypisKolik, VypisKamX, VypisKamY: integer); { to same pro integer }
begin
	gotoXY(VypisKamX,VypisKamY);
	write(VypisKolik);
end;

procedure VypisSablonu; { dela stale prostredi TextUserInterfacu }
begin
	{ *** udelame zlutej Ramecek *** }
	TextColor(Barva2zluta);

	Ramecek(ZacatekCarMenu,VrsekCarMenu,KonecCarMenu,RozliseniY);	{ Ramecek kolem menu }

	gotoXY(2,3);
	VodorovnaCara(RozliseniX-2,'=');				{ cara na radku 3 }

	Ramecek(1,1,RozliseniX,RozliseniY);				{ Ramecek kolem dokola }
	{ END zluteho ramecku *** }

	{ zacnem informativni programovy veci }
	TextColor(BarvaTyrkys);

	{ verze }
	VypisCoKam(programName + '  ' + version,versionX,versionY);

	{ (c)opyright }
	VypisCoKam(copyright,copyrightX,copyrightY);

	{ menu, tucne bile }
	TextColor(Barva2bila);

	VypisCoKam(LangMenuNovy,MenuVsechnoX,MenuNovyY);
	VypisCoKam(LangMenuHlMenu,MenuVsechnoX,MenuHlMenuY);
	VypisCoKam(LangMenuAbout,MenuVsechnoX,MenuAboutY);
	VypisCoKam(LangMenuKonec,MenuVsechnoX,MenuKonecY);


	TextColor(BarvaNative);

end;

procedure ZobrazMenu(pozice:integer); { zobrazuje jezdec v menu }
var	i:	MenuPrvni..MenuPosledni;
begin

	{ smaz hvezdicku at je kde je }
	for i:=MenuPrvni to MenuPosledni do
	begin
		gotoXY(MenuZacniX,MenuZacniY+i);
		write(' ');
	end;

	{ napis novou }
	gotoXY(MenuZacniX,MenuZacniY+pozice);
	TextColor(Barva2zelena);
	write('*');
	TextColor(BarvaNative);

end;

procedure Vycisti; { nechame jen kostru }
begin
	window(2,4,RozliseniX-1,MenuZacniY-2); { vycistim jednu cast }
	ClrScr;

	window(textyX,text1Y,RozliseniX-1,text3Y); { vycistim druhou cast }
	ClrScr;

	window(znackaX,znackaY,RozliseniX-1,znackaY); { vycistim treti cast }
	ClrScr;

	window(1,1,RozliseniX,RozliseniY); { zpatky na stromy }
end;

procedure FrakcniBanky(iks,ypsilon: integer); { nakresli krasne banky }
var	banky:				array [1..6] of string[16];
	radky:				1..6;
	pozice:				1..16;
	BarvaVypln, BarvaNadoba:	word;
begin

	banky[1]:='   o            ';
	banky[2]:='  \ /      | |  ';
	banky[3]:='  |o|      |@|  ';
	banky[4]:=' /o  \    /  @\ ';
	banky[5]:='|  o  |  |  @  |';
	banky[6]:='\_____/  |_____|';

	for radky:=1 to 6 do
	begin
		BarvaVypln:= Barva2zelena;
		BarvaNadoba:=Barva2modra;
		for pozice:=1 to 16 do
		begin
			if pozice = 8 then
			begin
				BarvaVypln:= Barva2ruzova;
				BarvaNadoba:=Barva2tyrkys;
			end;
			gotoXY(iks+pozice,ypsilon+radky);
			case banky[radky][pozice] of
				'o','@':	textcolor(BarvaVypln);
				'\','|','/','_':textcolor(BarvaNadoba);
			end;
			write(banky[radky][pozice]);
		end;
	end;
	textcolor(BarvaNative);
end;

procedure VypisInfo; { zepta se na prvek a vypise info }
var	JakyPrvek,umisteni,horni,dolni:	string;
	i,ID:				1..MaxPrvku;
	nenasel:			Boolean;
begin
	{ *** Prichazi BFU *** }

	nenasel:=TRUE;

	horni:=LangOKterem; { tyhle instrukce jen poprve }
	dolni:=LangHackyCarky;

	{ nejdriv udelam okynko, kde bude vypsan dotaz }
	window(DotazVlevo,DotazNahore,DotazVpravo,DotazDole);
	ClrScr; { umejeme }

	{ ohranicim ho a take pole pro vstup }
	TextColor(Barva2zluta); { zluta barva }
	Ramecek(MiniDotazVlevo,MiniDotazNahore,MiniDotazVpravo,MiniDotazDole); { mensi Ramecek }
	Ramecek(1,1,DotazVpravo-DotazVlevo+1,DotazDole-DotazNahore+1); { vetsi Ramecek }
	TextColor(BarvaNative); { zpet vychozi barva }

	while nenasel do
	begin
		{ vypisu horni a dolni text }
		VypisCoKam(horni,InstrukceX,InstrukceYa);
		VypisCoKam(dolni,InstrukceX,InstrukceYb);

		{ udelam jeste mensi okynko, aby mi BFU nepsal do TUI }
		window(InputVlevo,InputY,InputVpravo,InputY);
		ClrScr;
		readln(JakyPrvek); { utok! prichazi uzivatel }

		{ ted to najdu }
		for i:=1 to MaxPrvku do
		begin
			if (int2string(i)		= JakyPrvek)		or	{ hleda podle cisla }
			(UpCase(databaze[i].znacka)	= UpCase(JakyPrvek))	or	{ nebo zancky }
			(UpCase(databaze[i].jmeno)	= UpCase(JakyPrvek))	or	{ nebo jmena }
			(UpCase(databaze[i].latina)	= UpCase(JakyPrvek))	then	{ nebo latinskeho jmena }
			begin
				ID:=i;
				nenasel:=FALSE; { nebo nenejadu ? }
				break; {je zbytecne projizdet dal}
			end;
		end;
		horni:=LangNemam; { menim instrukce }
		dolni:=LangJen18;

		{ ted vratim stredni okynko }
		window(DotazVlevo,DotazNahore,DotazVpravo,DotazDole); { okno s dotazem }
	end;

	{ uklid }
	ClrScr; { pryc s tim }

	{ vsecko dat do poradku }
	window(1,1,RozliseniX,RozliseniY); { zpatky na stromy }

	{ *** Odchazi BFU *** }

	Vycisti;

	{ nazvy polozek, modre }
	TextColor(Barva2modra);
	VypisCoKam(LangNazev,nazevX,nazevY);
	VypisCoKam(LangProtonoveC,nazevX,protonovecY);
	VypisCoKam(LangRadioaktivni,nazevX,radioaktivniY);
	VypisCoKam(LangElektroneg,nazevX,elektronegY);
	VypisCoKam(LangIzotopy,nazevX,izotopyY);
	VypisCoKam(LangLatina,latinaX,latinaY);
	VypisCoKam(LangOxidacniC,latinaX,oxidacnicY);
	VypisCoKam(LangMolarniH,latinaX,molarni_hY);
	VypisCoKam(LangUmisteniPTP,umisteniX,umisteniY);
	VypisCoKam(LangValencni,valencniX,valencniY);
	VypisCoKam(LangSkupenstvi,skupenstviX,skupenstviY);
	VypisCoKam(LangLatka,skupenstviX,latkaY);
	VypisCoKam(LangHustota,skupenstviX,hustotaY);

	{ zelene hodnoty }
	TextColor(BarvaOlivova);
	with databaze[ID] do
	begin
		{ ted prijde trochu hnus, ale je to nejednodussi zpusob, jak to vypsat za dvojtecku }
		VypisCoKam(jmeno,nazevX+length(LangNazev)+1,nazevY);
		VypisKolikKam(z,nazevX+length(LangProtonoveC)+1,protonovecY);
		VypisCoKam(AnoNe(radioaktivni),nazevX+length(LangRadioaktivni)+1,radioaktivniY);
		VypisCoKam(real2string(elekneg),nazevX+length(LangElektroneg)+1,elektronegY);
		VypisCoKam(izotopy,nazevX+length(LangIzotopy)+1,izotopyY);
		VypisCoKam(latina,latinaX+length(LangLatina)+1,latinaY);
		VypisCoKam(oxidcislo,latinaX+length(LangOxidacniC)+1,oxidacnicY);
		VypisCoKam(real2string(molvaha),latinaX+length(LangMolarniH)+1,molarni_hY);
			umisteni:=group2string(sloupec); {to jsem si odsadil jen kvuli orientaci}
			umisteni:=umisteni+' - '+LangRadek;
			umisteni:=umisteni+' '+int2string(radek);
		VypisCoKam(umisteni,umisteniX+length(LangUmisteniPTP)+1,umisteniY);
		VypisCoKam(valencni,valencniX+length(LangValencni)+1,valencniY);
		VypisCoKam(char2skupenstvi(skupenstvi),skupenstviX+length(LangSkupenstvi)+1,skupenstviY);
		VypisCoKam(latka,skupenstviX+length(LangLatka)+1,latkaY);
		VypisCoKam(real2string(hustota)+' g/cm3',skupenstviX+length(LangHustota)+1,hustotaY);
		VypisCoKam(text1,textyX,text1Y);
		VypisCoKam(text2,textyX,text2Y);
		VypisCoKam(text3,textyX,text3Y);
		{ cerveny napis vpravo nahore }
		TextColor(Barva2cervena);
		VypisCoKam('* '+znacka+' *',znackaX,znackaY);
	end;

	FrakcniBanky(BankyX,BankyY);
	TextColor(BarvaNative);
	pozice:=MenuNovy;
	ZobrazMenu(pozice);
end;

procedure Wokinecko(jaky: char); { udela window() a napise do nej text, rovnou }
begin
	window(WoknoVlevo,WoknoNahore,WoknoVpravo,WoknoDole);

	if jaky='z' then
	begin
		FrakcniBanky(1,1);
		VypisCoKam('Vitej v programu paElemental.',21,1);
		VypisCoKam('V menu se pohybuj pomoci sipek nahoru ↑',21,4); { na woknech dat "^" }
		VypisCoKam('a dolu ↓.',52,5); { na woknech dat "v" }
		VypisCoKam('Volbu potvrdis klavesou [ENTER] nebo mezernikem.',21,7);
		VypisCoKam('Muzes pouzit i rychlou klavesu napsanou napravo.',21,10);
	end;

	if jaky='a' then
	begin
		writeln('   To, co vidite, je moje rocnikova prace z programovani, stala me');
		writeln('mnoho probdelych noci, nakonec - s vysledkem jsem spokojen.');

		writeln('   Pri psani tohoto programu jsem se vlastne ucil pracovat s jazykem');
		writeln('Pascal a take mit trpelivost :)');

		writeln('   Program obsahuje udaje o prvnich 18 prvcich z PTP, protoze samot-');
		writeln('ne pridavani udaju o vsech 118 je prace na mnohem delsi dobu. Mozna');
		writeln('to je skoda, ale pri teto praci byla dulezitejsi funkcnost.');

		writeln('   Aplikaci jsem kopmiloval pomoci Free Pascal Compileru, ktery je');
		writeln('zdarma dostupny pro nekolik platforem vcetne GNU/Linuxu.');

		VypisCoKam('Miroslav "churchyard" Hroncok - kveten 2007',26,11);
	end;

	window(1,1,RozliseniX,RozliseniY);
end;

procedure VypisZaklad; { udela zavadeci blbiny a napise uvodni pokec }
begin
	ClrScr;
	VypisSablonu;
	Wokinecko('z');
	pozice:=MenuPrvni; { pri startu programu mam byt menu nahore }
	ZobrazMenu(pozice);
end;

procedure VypisPokec(jaky:char); { zavola vypis pokecu }
begin
	Vycisti;
	Wokinecko(jaky);
	if jaky='z' then pozice:=MenuHlMenu;
	if jaky='a' then pozice:=MenuAbout;
	ZobrazMenu(pozice);
end;

procedure VykonejMenu(pozice:integer); { priradi entru/spacu proceduru z tech nahore, nebo skonci }
begin
	case pozice of
		MenuNovy:
		begin
			VypisInfo;
		end;

		MenuHlMenu:
		begin
			VypisPokec('z');
		end;

		{ dira }

		MenuAbout:
		begin
			VypisPokec('a');
		end;

		{ dira }

		MenuKonec:
		begin
			{ pocka a napise radek, samotne ukonceni musi byt v materskem cyklu }
			delay(EndDelay);

			gotoXY(RozliseniX,RozliseniY);
			writeln;
			breakni:=TRUE;
		end;
	end;
end;

procedure HlidejKlavesy(var pozice: shortint); { tak tohle hlida klavesnici }
begin
	repeat

		case readkey of
			KeyUp:
			begin
				dec(pozice);
				if (pozice=MenuDira1) or (pozice=MenuDira2) then dec(pozice); { vynech diry }
				while pozice < MenuPrvni do pozice:=pozice+MenuSkacuO; { behej dokola }
				ZobrazMenu(pozice);
			end;

			KeyDown:
			begin
				inc(pozice);
				if (pozice=MenuDira1) or (pozice=MenuDira2) then inc(pozice); { vynech diry }
				while pozice > MenuPosledni do pozice:=pozice-MenuSkacuO; { behej dokola }
				ZobrazMenu(pozice);
			end;

			KeyEnter, KeySpace:
			begin
				VykonejMenu(pozice);
			end;

			{ klavesove zkratky: }
			KeyN,Key_n:
			begin
				ZobrazMenu(MenuNovy);
				VykonejMenu(MenuNovy);
			end;

			KeyO,Key_o: { puvodni M odstraneno kvuli kolizi s klavesou > }
			begin
				ZobrazMenu(MenuHlMenu);
				VykonejMenu(MenuHlMenu);
			end;

			KeyA,Key_a:
			begin
				ZobrazMenu(MenuAbout);
				VykonejMenu(MenuAbout);
			end;

			KeyQ,Key_q:
			begin
				ZobrazMenu(MenuKonec);
				VykonejMenu(MenuKonec);
			end;
		end;

	until breakni;

end;

begin
	TextColor(BarvaNative);
	ZapisPrvky;
	VypisZaklad;
	HlidejKlavesy(pozice);
end.
