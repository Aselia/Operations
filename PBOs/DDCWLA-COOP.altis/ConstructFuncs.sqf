SAOKADDGUNGENERATED = {
private ["_sN","_pos","_dir","_gp","_earlier","_id","_class"];
_pos = + _this select 0;
_dir = _this select 1;
_sN = (surfaceNormal _pos);
_gp = [_pos] CALL RETURNGUARDPOST;
_class = ["I_HMG_01_high_F","I_GMG_01_high_F","I_HMG_01_high_F","I_GMG_01_high_F","I_static_AT_F","I_static_AA_F"] call RETURNRANDOM;
if (!isNil"IFENABLED") then {_class = ["SearchLight_GER","LIB_Pak40","LIB_Flakvierling_38","LIB_FlaK_38"] call RETURNRANDOM;
};
_earlier = _gp getvariable "StaticW";
_id = "N"+(format["%1",count _earlier]);
if (_class in ["LIB_FlaK_38","I_static_AT_F","I_static_AA_F"]) then {_pos = [(_pos select 0),(_pos select 1),2.5];};
_gp setvariable ["StaticW",_earlier + [[_class,_pos, (_dir+180), _sN,_id]],true];
//[_gp, [_class,getposATL _veh, direction _veh, (surfaceNormal (getposATL _veh)),_id]] CALL SAOKCONSADDW; "LIB_Pak40","LIB_FlaK_38",
};

SAOKCONSITEM = {
private ["_d","_classD","_p","_veh","_wTm","_myDisplay","_curS","_textA","_cost","_sel","_class","_pDir","_ps","_c","_preVO","_post","_ar","_sPp"];
//if (!isNil{SaOkmissionnamespace getvariable "IgOnce"}) exitWith {SaOkmissionnamespace setvariable ["IgOnce",nil];};
if (!isNil{SaOkmissionnamespace getvariable "ConsMoved"}) exitWith {if ((lbCurSel 1500) == ((SaOkmissionnamespace getvariable "ConsMoved") select 0) && {(lbCurSel 1501) == ((SaOkmissionnamespace getvariable "ConsMoved") select 1)}) then {SaOkmissionnamespace setvariable ["ConsMoved",nil];SaOkmissionnamespace setvariable ["IgOnce",1];};};
if (!isNil{SaOkmissionnamespace getvariable "CurObject"}) then {deletevehicle (SaOkmissionnamespace getvariable "CurObject");SaOkmissionnamespace setvariable ["CurObject",nil];SaOkmissionnamespace setvariable ["CurObjectDir",nil];};
disableserialization;
_myDisplay = findDisplay 1233;
_curS = (lbText [1500, (lbCurSel 1500)]);
SaOkmissionnamespace setvariable ["LastOb",(lbCurSel 1500)];
SaOkmissionnamespace setvariable ["CurrentOb",_curS];
_textA = "Price: ";
_cost = ((lbText [1500, (lbCurSel 1500)]) CALL CONSCOST)*([] CALL SAOKCONSRATE);
_textA = _textA + (format ["%1",_cost]);
(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _textA;
	_pDir = direction player;
	if (_pDir < 0) then {_pDir = _pDir + 360;};
	if (_pDir > 360) then {_pDir = _pDir - 360;};
	_pDir = _pDir + 180;
	if (_pDir > 360) then {_pDir = _pDir - 360;};
	sliderSetPosition [1900, _pDir];
	_sPp = 0;
	if (!isNil{(SaOkmissionnamespace getvariable "StepDir")}) then {_sPp = (SaOkmissionnamespace getvariable "StepDir");};
	sliderSetPosition [1902, _sPp];
	_sel = (lbCurSel 1500);
	SaOkmissionnamespace setvariable ["CurrentOb",_curS];
	_class = (lbText [1500, (lbCurSel 1500)]) CALL LUOKKANIMI;
	SaOkmissionnamespace setvariable ["CurrentClass",_class];
	SaOkmissionnamespace setvariable ["CurrentCat",(lbText [1501, (lbCurSel 1501)])];
	_post = [(getposATL player)] CALL RETURNGUARDPOST;
	_preVO = "";
	_ar = (_post getvariable "StaticO");
	if (!isNil"_ar") then {
	_c = count _ar;
	_preVO = "";
	if (_c > 0 && {_post distance player < 300}) then {
	_c = _c - 1;
	_preVO = (_ar select _c) select 0;
	};
	};
	if (isNil{SaOkmissionnamespace getvariable "Arrow"}) then {
	if !(_preVO in ["Land_HBarrierWall4_F","Field Toilet","Chair Plastic","Land_CampingChair_V1_F","Land_Mil_WiredFence_F","Land_Mil_WallBig_4m_F","Land_Shoot_House_Wall_Long_F","Land_CncWall4_F","Land_HBarrierBig_F","Land_HBarrier_5_F","Land_HBarrier_3_F","Land_BagFence_Round_F","Land_BagFence_Long_F"]) then {ctrlEnable [1606, false];ctrlEnable [1605, false];} else {ctrlEnable [1606, true];ctrlEnable [1605, true];};
	} else {
	if (SaOkmissionnamespace getvariable "Arrow" == -1) then {
	ctrlEnable [1605, false];ctrlEnable [1606, true];
	} else {
	ctrlEnable [1605, true];ctrlEnable [1606, false];
	};
	};
	//if (isNil{SaOkmissionnamespace getvariable "DrawFF"}) then {ctrlEnable [1606, false];};
	_d = 0;
	if (_class in ["LIB_Pak40","LIB_FlaK_38","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_MBT_03_cannon_F","B_APC_Tracked_01_AA_F","I_Mortar_01_F","I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F"]) then {_d = 180;};
	_veh = objNull;
	if !(_class in ["AA-Guard","AT-Guard","Sniper-Guard","Medic-Guard","MG-Guard"]) then {
	_classD = _class;
	if (_class in ["LIB_Pak40","LIB_FlaK_38","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_MBT_03_cannon_F","B_APC_Tracked_01_AA_F","I_Mortar_01_F","I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F"]) then {_classD = "Sign_Arrow_Direction_Pink_F";};
	_p = screenToWorld [0.5,0.5];
	_veh = createVehicle [_classD, _p, [], 0, "CAN_COLLIDE"];
	//_wTm = _veh worldToModel _p;
	_wTm = [0,0,0];
	_ps = [(_p select 0)-(_wTm select 0),(_p select 1)-(_wTm select 1),0];
	_veh setpos _ps;
	_veh setvectorup (surfaceNormal (getposATL _veh));
	_veh setvariable ["Ghost",1];
	_veh setdir ((sliderPosition 1900)+_d); 
	SaOkmissionnamespace setvariable ["CurObject",_veh];
	SaOkmissionnamespace setvariable ["CurObjectDir",_d];
	SaOkmissionnamespace setvariable ["CurObjectHeight",0];
	SaOkmissionnamespace setvariable ["CurObjectPos",_ps];
	};
};

SAOKCONSMOVEOBJ = {
private ["_p","_wTm","_veh","_ps","_pPos"];
if (!isNil{SaOkmissionnamespace getvariable "CurObject"}) then {
closeDialog 0;
if (!isNil{SaOkmissionnamespace getvariable "LastOb"} && {!isNil{SaOkmissionnamespace getvariable "LastCat"}}) then {
SaOkmissionnamespace setvariable ["ConsMoved",[(SaOkmissionnamespace getvariable "LastOb"),(SaOkmissionnamespace getvariable "LastCat")]];
};
_p = screenToWorld [0.5,0.5];
_veh = (SaOkmissionnamespace getvariable "CurObject");
_veh setpos _p;
_wTm = if (!isNil{_veh worldToModel _p}) then {_veh worldToModel _p} else {[0,0,0]};
_wTm set [0,(_wTm select 0)*0.5];
_wTm set [1,(_wTm select 1)*0.5];
_wTm set [2,0];
//_timeT = time + 2.5;
_pPos = getposATL player;
SaOkmissionnamespace setvariable ["MovingObj",1];
LIIKUTAOBJEKTI = true;
"Press SHIFT+C again to return, or move over 5 meters" SPAWN HINTSAOK;
sleep 0.02;
if (isNil"_wTm") exitWith {[(SaOkmissionnamespace getvariable "LastOb"),(SaOkmissionnamespace getvariable "LastCat")] CALL SAOKCONSDIAGNEW;LIIKUTAOBJEKTI = nil;};
while {!dialog && {_pPos distance (getposATL player) < 5} && {!isNil{SaOkmissionnamespace getvariable "MovingObj"}} && {!isNil"LIIKUTAOBJEKTI"}} do {
_p = screenToWorld [0.5,0.5]; 
_ps = [(_p select 0)-(_wTm select 0),(_p select 1)-(_wTm select 1),0];
if (isNil"_ps") exitWith {LIIKUTAOBJEKTI = nil;};
_veh setpos _ps;
_veh setvectorup (surfaceNormal (getposATL _veh));
sleep 0.02;
};
LIIKUTAOBJEKTI = nil;
if (isNil"_ps") exitWith {[(SaOkmissionnamespace getvariable "LastOb"),(SaOkmissionnamespace getvariable "LastCat")] CALL SAOKCONSDIAGNEW;};
SaOkmissionnamespace setvariable ["CurObjectPos",_ps];
//_veh setvectorup (surfaceNormal (getposATL _veh));
[(SaOkmissionnamespace getvariable "LastOb"),(SaOkmissionnamespace getvariable "LastCat")] CALL SAOKCONSDIAGNEW;
};
};

//_post setvariable ["StaticOS",_earlier + [[_class,_p, direction _x, (surfaceNormal (getposATL _x)),_id]]];
SAOKSIDESTEP = {
private ["_wTm","_c","_preVO","_oldD","_nul","_p","_d","_dir","_obj","_bBox","_p1","_p2","_maxWidth","_maxLength","_maxHeight","_start","_earlier","_id","_li","_post","_ar","_pr","_Sdir","_n"];
_n = if (typename _this != "ARRAY") then {1} else {-1};
_post = if (typename _this != "ARRAY") then {_this} else {_this select 0};
if (typename _this != "ARRAY") then {ctrlEnable [1605, true];ctrlEnable [1606, false];SaOkmissionnamespace setvariable ["Arrow",1];} else {ctrlEnable [1605, false];ctrlEnable [1606, true];SaOkmissionnamespace setvariable ["Arrow",-1];};
_preVO = "";
_ar = (_post getvariable "StaticO");
_c = count _ar;
if (_c > 0) then {
_c = _c - 1;
_preVO = (_ar select _c) select 0;
};
if (_preVO == "") exitWith {};
_pr = _preVO CALL CONSCOST;
if (([side player] CALL PrestigeS) >= _pr) then {
_nn = [side player,-_pr] SPAWN PrestigeUpdate;
[[-_pr, "Construction"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
_p = (_ar select _c) select 1;
_d = (_ar select _c) select 2;
_dir = 90 + _d;
_obj = createVehicle [_preVO, _p, [], 0, "CAN_COLLIDE"]; 
//_wTm = _obj worldToModel _p;
_bBox = boundingBoxReal _obj;
_p1 = _bBox select 0;
_p2 = _bBox select 1;
_Sdir = 0;
if (!isNil{(SaOkmissionnamespace getvariable "StepDir")}) then {_Sdir =(SaOkmissionnamespace getvariable "StepDir");};
_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
_maxLength = abs ((_p2 select 1) - (_p1 select 1));
_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
_start = [(_p select 0)+((sin _dir)*_maxWidth*0.5)*_n+((sin (_Sdir+_dir))*_maxWidth*0.5)*_n,(_p select 1)+((cos _dir)*_maxWidth*0.5)*_n+((cos (_Sdir+_dir))*_maxWidth*0.5)*_n,0];
_obj setpos _start;
//_obj setpos [(_pos select 0)+(_wTm select 0),(_pos select 1)+(_wTm select 1),0];
//_obj setvectorup (surfaceNormal (getposATL _obj));
_earlier = +(_post getvariable "StaticO");
_id = (format ["N%1",(count _earlier)]);
_li = [[_preVO,_start,(_d+_Sdir),(surfaceNormal _start),_id]];
_post setvariable ["StaticO",(_earlier + _li),true];
if (isNil{_post getvariable "ObjectsNow"}) then {_post setvariable ["ObjectsNow",[[_obj,_id]],true];} else {_oldD = _post getvariable "ObjectsNow";_post setvariable ["ObjectsNow",(_oldD+[[_obj,_id]]),true];};
_wTm = _obj worldToModel _start;
_wTm set [2,0];
_obj setpos [(_start select 0)+(_wTm select 0),(_start select 1)+(_wTm select 1),0];
_obj setdir (_d+_Sdir);
_obj setvectorup (surfaceNormal (getposATL _obj));
} else {
"Not enough prestige" SPAWN HINTSAOK;
};
};

SAOKCONSDIAGNEW = {
private ["_ok","_myDisplay","_class","_curS","_textA","_cost","_post","_d","_c","_preVO","_ar","_sPp"];
disableserialization;
_ok = createDialog "ConstructionDialog"; 
_post = [(getposATL player)] CALL RETURNGUARDPOST;
_myDisplay = findDisplay 1233;
_class = SaOkmissionnamespace getvariable "CurrentClass";
if (!isNil{_post getvariable "GCreator"} && {(_post getvariable "GCreator") == name player}) then {ctrlEnable [1607, true];} else {ctrlEnable [1607, false];};
if (!isNil{_post getvariable "StaticOS"} && {count (_post getvariable "StaticOS") > 0}) then {ctrlEnable [1607, false];};
ctrlEnable [1608, false];
sliderSetRange [1900, 0, 360];
sliderSetRange [1901, 0, 10];
sliderSetRange [1902, -90, 90];
_d = if (!isNil{SaOkmissionnamespace getvariable "CurObjectHeight"}) then {SaOkmissionnamespace getvariable "CurObjectHeight"} else {0};
sliderSetPosition [1901, _d];
sliderSetPosition [1900, (SaOkmissionnamespace getvariable "ConsSlip")];
_sPp = 0;
if (!isNil{(SaOkmissionnamespace getvariable "StepDir")}) then {_sPp = (SaOkmissionnamespace getvariable "StepDir");};
sliderSetPosition [1902, _sPp];
_preVO = "";
_ar = (_post getvariable "StaticO");
	if (!isNil"_ar") then {
	_c = count _ar;
	_preVO = "";
	if (_c > 0 && {_post distance player < 300}) then {
	_c = _c - 1;
	_preVO = (_ar select _c) select 0;
	};
	};
	
if (isNil{SaOkmissionnamespace getvariable "Arrow"}) then {
if !(_preVO in ["Land_HBarrierWall4_F","Field Toilet","Chair Plastic","Land_CampingChair_V1_F","Land_Mil_WiredFence_F","Land_Mil_WallBig_4m_F","Land_Shoot_House_Wall_Long_F","Land_Shoot_House_Wall_Long_F","Land_Mil_WallBig_4m_F","Land_Mil_WiredFence_F","Land_CncWall4_F","Land_HBarrierBig_F","Land_HBarrier_5_F","Land_HBarrier_3_F","Land_BagFence_Round_F","Land_BagFence_Long_F"]) then {ctrlEnable [1606, false];ctrlEnable [1605, false];} else {ctrlEnable [1606, true];ctrlEnable [1605, true];};
} else {
if (SaOkmissionnamespace getvariable "Arrow" == -1) then {
ctrlEnable [1605, false];ctrlEnable [1606, true];
} else {
ctrlEnable [1605, true];ctrlEnable [1606, false];
};
};
//if (isNil{SaOkmissionnamespace getvariable "DrawFF"}) then {ctrlEnable [1606, false];};
lbAdd [1501, "Fortress"];
if (_post distance (getposATL player) < 120) then {
lbAdd [1501, "Objects"];
lbAdd [1501, "Special"];
lbAdd [1501, "Furniture"];
lbAdd [1501, "AI Weapons"];
if ("ResHelp" in (SaOkmissionnamespace getvariable "Progress")) then {
lbAdd [1501, "AI Guards"];
lbAdd [1501, "AI Vehicles"];
};
};
lbSetCurSel [1501, _this select 1];
lbSetCurSel [1500, _this select 0];
_curS = (lbText [1500, (lbCurSel 1500)]);
SaOkmissionnamespace setvariable ["CurrentOb",_curS];
_textA = "Price: ";
_cost = ((lbText [1500, (lbCurSel 1500)]) CALL CONSCOST)*([] CALL SAOKCONSRATE);
_textA = _textA + (format ["%1",_cost]);
(_myDisplay displayCtrl 1100) ctrlSetStructuredText parseText _textA;
};
SAOKBUYDELAY = {BUYING = true; sleep 0.5; BUYING = nil;};

SAOKCONSBUY = {
private ["_arriside","_u","_objs","_post","_earlier","_id","_nul","_vaara","_dddd","_nRPP","_ngg","_ukkoLimit","_aseLimit","_class","_limitsF","_curS","_veh","_cost","_p","_wTm","_Vp","_Vp2","_Vp3","_n","_postP"];
[] SPAWN SAOKBUYDELAY;
_limitsF = {
private ["_uk","_ase"];
_uk = 3;
_ase = 2;
switch (typeof _this) do {
case "Land_BagBunker_Small_F": {_uk = 2;_ase = 1;};
case "Land_HBarrierTower_F": {_uk = 3;_ase = 2;};
case "Land_BagBunker_Large_F": {_uk = 3;_ase = 2;};
case "Land_BagBunker_Tower_F": {_uk = 3;_ase = 2;};
case "Land_Cargo_Patrol_V2_F": {_uk = 4;_ase = 3;};
case "Land_Cargo_HQ_V1_F": {_uk = 5;_ase = 4;};
case "trench_tank1": {_uk = 4;_ase = 3;};
case "trench_big1": {_uk = 5;_ase = 4;};
case "trench_mg1": {_uk = 3;_ase = 2;};
case "trench_mg2": {_uk = 2;_ase = 1;};
case "trench_mortar": {_uk = 2;_ase = 1;};
};
[_uk,_ase]
};
	SaOkmissionnamespace setvariable ["Arrow",nil];
	_curS = SaOkmissionnamespace getvariable "CurrentOb";
	_veh = if (isNil{SaOkmissionnamespace getvariable "CurObject"}) then {objNull} else {SaOkmissionnamespace getvariable "CurObject"};
	_class = SaOkmissionnamespace getvariable "CurrentClass";
	if ("Sign_Arrow_Direction_Blue_F" == _class) exitWith {
	_cost = (_curS CALL CONSCOST)*([] CALL SAOKCONSRATE);
	if (([side player] CALL PrestigeS) >= _cost) then {
	_n = [side player,-_cost] SPAWN PrestigeUpdate;
	[[-_cost, "Construction"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	_Vp = getposATL _veh;
	_post = [_Vp] CALL RETURNGUARDPOST;
	_objs = _Vp CALL POWcell;
	{
	_class = typeof _x;
	_earlier = _post getvariable "StaticOS";
	_id = "NS"+(format["%1",count _earlier]);
	_p = getposATL _x;
	_wTm = _x worldToModel _p;
	_p = [(_p select 0)+(_wTm select 0),(_p select 1)+(_wTm select 1),0];
	_post setvariable ["StaticOS",_earlier + [[_class,_p, direction _x, (surfaceNormal (getposATL _x)),_id]],true];
	[_post, [_x,_id]] CALL SAOKCONSADDO;
	} foreach _objs;
	_Vp2 = [(_Vp select 0)+2,(_Vp select 1)+2, 0];
	_Vp3 = [(_Vp select 0)-2,(_Vp select 1)+3, 0];
	if (isNil{_post getvariable "PowCells"}) then {_post setvariable ["PowCells",[[_Vp,""],[_Vp2,""],[_Vp3,""]],true];} else {_post setvariable ["PowCells",((_post getvariable "PowCells")+[[_Vp,""],[_Vp2,""],[_Vp3,""]]),true];};
	deletevehicle _veh;
	SaOkmissionnamespace setvariable ["CurrentOb",nil];
	SaOkmissionnamespace setvariable ["CurObject",nil];
	} else {"Not enough presige value to construct" SPAWN HINTSAOK;};
	
	};
	_cost = (_curS CALL CONSCOST)*([] CALL SAOKCONSRATE);
	if (_class in ["Land_TentA_F","Land_CampingChair_V1_F","Land_Cargo_House_V1_F","Land_dp_smallTank_F","Land_dp_smallFactory_F","Land_dp_mainFactory_F","Land_MilOffices_V1_F","Land_Radar_Small_F","Land_Radar_F","Land_TTowerBig_2_F","Land_TTowerBig_1_F","Land_Pallet_F","Land_Scaffolding_F","Land_Shoot_House_Wall_Long_F","Land_Mil_WallBig_4m_F","Land_Mil_WiredFence_F","Land_PowerGenerator_F","Land_PortableLight_double_F","Land_PortableLight_single_F","Land_FieldToilet_F","Land_Sink_F","Land_CampingTable_F","Land_Camping_Light_F","Land_WoodenTable_small_F","Land_ShelvesWooden_F","Land_TableDesk_F","Land_ChairPlastic_F","MapBoard_altis_F","Land_TBox_F","Land_TTowerSmall_1_F","Land_CncWall4_F","Land_LampHalogen_F","Box_IND_Wps_F","Land_HelipadSquare_F","FirePlace_burning_F","Land_TentDome_F","Land_HBarrierWall4_F","CamoNet_BLUFOR_F","CamoNet_BLUFOR_open_F","CamoNet_BLUFOR_big_F","Land_BarrelWater_F","Land_BagFence_Long_F","Land_BagFence_Round_F","Land_HBarrier_3_F","Land_HBarrier_5_F","Land_HBarrierBig_F","Land_Razorwire_F","Land_Crash_barrier_F","Land_BarGate_F"]) then {
	if (([side player] CALL PrestigeS) >= _cost && {isNil{_post getvariable "StaticO"} || {count (_post getvariable "StaticO") < 78} || {!GUARDLIM}}) then {
	_veh setvariable ["Ghost",nil];
	_veh setvariable ["AmCrate",1,true];
	if !(_class in ["FirePlace_burning_F"]) then {[_veh,0] SPAWN VehLife;};
	_n = [side player,-_cost] SPAWN PrestigeUpdate;
	[[-_cost, "Construction"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	if (_class in ["Land_TentDome_F","Land_TentA_F"]) then {
	_post = ([(getposATL _veh)] CALL RETURNGUARDPOST);
	_post setvariable ["CampV",1,true];
	//(_post getvariable "Gmark") setMarkerText " Guardpost with tent(s)";
	};
	
	_post = ([(getposATL _veh)] CALL RETURNGUARDPOST);
	if !(_class in ["Land_Cargo_House_V1_F","Land_dp_smallTank_F","Land_dp_smallFactory_F","Land_dp_mainFactory_F","Land_MilOffices_V1_F","Land_Radar_Small_F","Land_Radar_F","Land_TTowerBig_2_F","Land_TTowerBig_1_F"]) then {
	_earlier = _post getvariable "StaticO";
	_id = "N"+(format["%1",count _earlier]);
	_post setvariable ["StaticO",_earlier + [[_class,getposATL _veh, direction _veh, (surfaceNormal (getposATL _veh)),_id]],true];
	} else {
	_earlier = if (!isNil{_post getvariable "StaticOS"}) then {_post getvariable "StaticOS"} else {[]};
	_id = "NS"+(format["%1",count _earlier]);
	_post setvariable ["StaticOS",_earlier + [[_class,getposATL _veh, direction _veh, (surfaceNormal (getposATL _veh)),_id]],true];
	if (_class == "Land_dp_mainFactory_F") then {[getposATL _veh,"Fac"] CALL SAOKCREATESTPOINT;};
	if (_class in ["Land_dp_smallFactory_F","Land_dp_smallTank_F"]) then {[getposATL _veh,"Sto"] CALL SAOKCREATESTPOINT;};
	if (_class == "Land_MilOffices_V1_F") then {"MilOff" CALL SAOKADDPROG;};
	if (_class == "Land_Radar_Small_F") then {"RadarS" CALL SAOKADDPROG;};
	if (_class == "Land_Radar_F") then {"Radar" CALL SAOKADDPROG;};
	if (_class == "Land_TTowerBig_2_F") then {"MilTower" CALL SAOKADDPROG;};
	if (_class == "Land_TTowerBig_1_F") then {"MilTower" CALL SAOKADDPROG;};
	//if (_class == "Land_Cargo_House_V1_F") then {"MilTower" CALL SAOKADDPROG;};
	//CALL SAOKADDPROG;
	};
	[_post, [_veh,_id]] CALL SAOKCONSADDO;

	} else {
	deletevehicle _veh; if (([side player] CALL PrestigeS) < _cost) then {"Not enough presige value to construct" SPAWN HINTSAOK;} else {"Object build limit reached in this guardpost" SPAWN HINTSAOK;};
	};
	};
	
	if (_class in ["Box_IND_Wps_F"]) then {([(getposATL _veh)] CALL RETURNGUARDPOST) setvariable ["StorageBox",[]];};
	
	if (_class in ["trench_mg1","trench_mg2","trench_tank1","trench_big1","trench_mortar","Land_Cargo_HQ_V1_F","Land_Cargo_Patrol_V2_F","Land_BagBunker_Small_F","Land_BagBunker_Large_F","Land_BagBunker_Tower_F","Land_HBarrierTower_F"]) then {
	if (([side player] CALL PrestigeS) >= _cost) then {
	_veh setvariable ["Ghost",nil];
	_n = [side player,-_cost] SPAWN PrestigeUpdate;
	[[-_cost,  "Construction"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	_nRPP = ([(getposATL _veh)] CALL RETURNGUARDPOST);
	_vaara = "ColorGreen";
	if (side player == WEST) then {_vaara = "ColorRed";};
	_dddd = 120;
	if (!GUARDLIM) then {_dddd = 120;};
	if (_nRPP distance _veh > _dddd || {getmarkercolor (_nRPP getvariable "Gmark") == _vaara}) then {
	[_veh] CALL GUARDPOST;
	_post = _veh;
	_post allowdamage false;
	_post setvariable ["StaticW",[],true];
	_post setvariable ["StaticO",[],true];
	_post setvariable ["StaticOS",[],true];
	_post setvariable ["GCreator",name player,true];
	} else {
	_post = ([(getposATL _veh)] CALL RETURNGUARDPOST);
	_earlier = _post getvariable "StaticO";
	_id = "N"+(format["%1",count _earlier]);
	//hint _id;
	_post setvariable ["StaticO",_earlier + [[_class,getposATL _veh, direction _veh, (surfaceNormal (getposATL _veh)),_id]],true];
	[_post, [_veh,_id]] CALL SAOKCONSADDO;
	//deletevehicle _veh;
	};
	
	} else {
	_veh setvariable ["Ghost",nil];
	deletevehicle _veh; "Not enough presige value to construct" SPAWN HINTSAOK;
	};
	};
	

	if !(_class in ["trench_mg1","trench_mg2","trench_tank1","trench_big1","trench_mortar","LIB_Pak40","LIB_FlaK_38","Land_TentA_F","Land_Cargo_House_V1_F","Land_dp_smallTank_F","Land_dp_smallFactory_F","Land_dp_mainFactory_F","Land_MilOffices_V1_F","Land_Radar_Small_F","Land_Radar_F","Land_TTowerBig_2_F","Land_TTowerBig_1_F","Land_Pallet_F","Land_Scaffolding_F","Land_Shoot_House_Wall_Long_F","Land_Mil_WallBig_4m_F","Land_Mil_WiredFence_F","Land_PowerGenerator_F","Land_PortableLight_double_F","Land_PortableLight_single_F","Land_FieldToilet_F","Land_Sink_F","Land_CampingTable_F","Land_Camping_Light_F","Land_WoodenTable_small_F","Land_CampingChair_V1_F","Land_ShelvesWooden_F","Land_TableDesk_F","Land_ChairPlastic_F","MapBoard_altis_F","Land_TBox_F","Land_TTowerSmall_1_F","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_MBT_03_cannon_F","B_APC_Tracked_01_AA_F","Land_Cargo_HQ_V1_F","Land_CncWall4_F","Land_Cargo_Patrol_V2_F","Land_LampHalogen_F","I_Mortar_01_F","I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","MG-Guard","AA-Guard","AT-Guard","Sniper-Guard","Medic-Guard","Box_IND_Wps_F","Land_BagBunker_Small_F","Land_BagBunker_Large_F","Land_BagBunker_Tower_F","Land_HBarrierTower_F","Land_HelipadSquare_F","FirePlace_burning_F","Land_TentDome_F","Land_HBarrierWall4_F","CamoNet_BLUFOR_F","CamoNet_BLUFOR_open_F","CamoNet_BLUFOR_big_F","Land_BarrelWater_F","Land_BagFence_Long_F","Land_BagFence_Round_F","Land_HBarrier_3_F","Land_HBarrier_5_F","Land_HBarrierBig_F","Land_Razorwire_F","Land_Crash_barrier_F","Land_BarGate_F"]) then {
	if (([side player] CALL PrestigeS) >= _cost) then {
	_veh setvariable ["Ghost",nil];
	_n = [side player,-_cost] SPAWN PrestigeUpdate;
	[[-_cost, "Construction"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	//[_veh] CALL GUARDPOST;
	} else {
	_veh setvariable ["Ghost",nil];
	deletevehicle _veh; "Not enough presige value to construct" SPAWN HINTSAOK;
	};
	};
	
	if (_class in ["MG-Guard","AA-Guard","AT-Guard","Sniper-Guard","Medic-Guard"]) then {
	_ngg =([(getposATL player)] CALL RETURNGUARDPOST);
	
	_ukkoLimit = (_ngg CALL _limitsF) select 0;
	if (([side player] CALL PrestigeS) >= _cost && {isNil {_ngg getvariable _class}} && {({!isNil{_ngg getvariable _x}} count ["MG-Guard","AA-Guard","AT-Guard","Sniper-Guard","Medic-Guard"] < _ukkoLimit  || {!GUARDLIM})}) then {
	_n = [side player,-_cost] SPAWN PrestigeUpdate;
	[[-_cost, "Construction"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	_ngg setvariable [_class,1,true];
	_u = [_ngg,_class] CALL SAOKCONSADDU;
	_postP = getposATL _ngg;
	_arriSide = if (getmarkercolor (_ngg getvariable "Gmark") == "ColorGreen") then {WEST} else {EAST};
	if ({vehicle _x distance _postP < 450 && {isNil{_x getvariable "JustTeleported"}}} count [player] > 0) then {
	_n = [_u, _arriSide, _postP,[],_postP,""] SPAWN VehicleArrivalA;
	} else {
	[[_u],"AICampBehaviour",false,false] spawn BIS_fnc_MP;
	//_nul = [_u] SPAWN AICampBehaviour;
	
	};

	} else {
	if !({!isNil{_ngg getvariable _x}} count ["MG-Guard","AA-Guard","AT-Guard","Sniper-Guard","Medic-Guard"] < _ukkoLimit) then {
	"No more AI teams is allowed in this guardpost" SPAWN HINTSAOK;
	} else {
	if (!isNil {([(getposATL player)] CALL RETURNGUARDPOST) getvariable _class}) then {
	_veh setvariable ["Ghost",nil];
	deletevehicle _veh; "Guardpost already have that guard" SPAWN HINTSAOK;
	} else {
	_veh setvariable ["Ghost",nil];
	deletevehicle _veh; "Not enough presige value to construct" SPAWN HINTSAOK;
	};
	};
	};
	};
	if (_class in ["LIB_Pak40","LIB_FlaK_38","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_MBT_03_cannon_F","B_APC_Tracked_01_AA_F","I_Mortar_01_F","I_static_AT_F","I_static_AA_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F"]) then {
	_ngg =([(getposATL player)] CALL RETURNGUARDPOST);
	_aseLimit = (_ngg CALL _limitsF) select 1;
	if (([side player] CALL PrestigeS) >= _cost && {isNil{_ngg getvariable "StaticW"} || {count (_ngg getvariable "StaticW") < _aseLimit} || {!GUARDLIM}}) then {
	_n = [side player,-_cost] SPAWN PrestigeUpdate;
	[[-_cost, "Static Weapon"],"PRESTIGECHANGE",nil,false] spawn BIS_fnc_MP;
	_earlier = ([(getposATL player)] CALL RETURNGUARDPOST) getvariable "StaticW";
	_id = "N"+(format["%1",count _earlier]);
	//hint _id;
	([(getposATL player)] CALL RETURNGUARDPOST) setvariable ["StaticW",_earlier + [[_class,getposATL _veh, direction _veh, (surfaceNormal (getposATL _veh)),_id]],true];
	[_ngg, [_class,getposATL _veh, direction _veh, (surfaceNormal (getposATL _veh)),_id]] CALL SAOKCONSADDW;
	deletevehicle _veh;
	} else {deletevehicle _veh;if (([side player] CALL PrestigeS) < _cost) then {"Not enough presige value to construct" SPAWN HINTSAOK;} else {"Weapon build limit reached in this guardpost" SPAWN HINTSAOK;};};
	};
	SaOkmissionnamespace setvariable ["CurrentOb",nil];
	SaOkmissionnamespace setvariable ["CurObject",nil];
	SaOkmissionnamespace setvariable ["CurObjectHeight",nil];
	SaOkmissionnamespace setvariable ["CurObjectPos",nil];
};

SAOKDIARESET = {
if (SaOkmissionnamespace getvariable "CurrentCat" != "Furniture") then {
	[(SaOkmissionnamespace getvariable "LastOb"),(SaOkmissionnamespace getvariable "LastCat")] SPAWN SAOKCONSDIAGNEW;
	} else {SaOkmissionnamespace setvariable ["ConsMoved",nil];};
};

SAOKCONSSLIDER = {
private ["_veh","_d","_sliP"];
if (!isNil{SaOkmissionnamespace getvariable "CurObject"}) then {
_veh = SaOkmissionnamespace getvariable "CurObject";
_d = SaOkmissionnamespace getvariable "CurObjectDir";
_veh setdir ((sliderPosition 1900)+_d); 
_sliP = (sliderPosition 1900); 
SaOkmissionnamespace setvariable ["ConsSlip",_sliP];
_veh setvectorup (surfaceNormal (getposATL _veh));
};
};

SAOKCONSSLIDER3 = {
private ["_sliP"];
_sliP = (sliderPosition 1902); 
SaOkmissionnamespace setvariable ["StepDir",_sliP];
};

SAOKCONSSLIDER2 = {
private ["_veh","_d","_curPos"];
if (!isNil{SaOkmissionnamespace getvariable "CurObject"}) then {
_veh = SaOkmissionnamespace getvariable "CurObject";
_d = SaOkmissionnamespace getvariable "CurObjectHeight";
_curPos = SaOkmissionnamespace getvariable "CurObjectPos";
_curPos set [2, ((sliderPosition 1901)+_d)];
_veh setpos _curPos; 
_veh setvectorup (surfaceNormal _curPos);
};
};

SAOKCONSCATHEGORY = {
SaOkmissionnamespace setvariable ["LastCat",(lbCurSel 1501)];
lbClear 1500;
switch _this do {
case "Fortress": {
lbAdd [1500, "Small BagBunker"];
if (isNil"IFENABLED") then {
lbAdd [1500, "Tower Bunker"];
};
lbAdd [1500, "Large BagBunker"];
lbAdd [1500, "Tower BagBunker"];
if (isNil"IFENABLED") then {
lbAdd [1500, "H Barrier Tower"];
lbAdd [1500, "Big Steel Bunker"];
};
if (!isNil"IFENABLED") then {
lbAdd [1500, "Tank Trench"];
lbAdd [1500, "Big Trench"];
lbAdd [1500, "MG Trench"];
lbAdd [1500, "MG Trench 2"];
lbAdd [1500, "Mortar Trench"];
};
};
case "Objects": {
lbAdd [1500, "Long BagFence"];
lbAdd [1500, "House Wall"];
lbAdd [1500, "Military Wall"];
lbAdd [1500, "Wired Fence"];
if (isNil"IFENABLED") then {
lbAdd [1500, "Concrete Wall"];
lbAdd [1500, "H-Barrier 3"];
lbAdd [1500, "H-Barrier 5"];
lbAdd [1500, "Big H-Barrier"];
lbAdd [1500, "H-Barrier Wall"];
};
lbAdd [1500, "BarGate"];
lbAdd [1500, "HeliPad"];
lbAdd [1500, "Scaffolding"];
lbAdd [1500, "Halogen Lamp"];
lbAdd [1500, "Razorwire"];
lbAdd [1500, "Round BagFence"];
lbAdd [1500, "CamoNet"];
lbAdd [1500, "CamoNet Open"];
lbAdd [1500, "CamoNet Vehicle"];
};
case "Special": {
[["WLA","SpecialStructures"]] call BIS_fnc_advHint;
lbAdd [1500, "Antenna"];
lbAdd [1500, "Gear Storage"];
lbAdd [1500, "Cargo House"];
lbAdd [1500, "Pow Cell"];
lbAdd [1500, "Transmitter Tower 1"];
lbAdd [1500, "Transmitter Tower 2"];
lbAdd [1500, "Radar"];
lbAdd [1500, "Small Radar"];
lbAdd [1500, "Military Offices"];
lbAdd [1500, "Factory"];
lbAdd [1500, "Storage"];
lbAdd [1500, "Silo"];
};
case "Furniture": {
lbAdd [1500, "Tent"];
lbAdd [1500, "Pallet"];
lbAdd [1500, "FirePlace"];
lbAdd [1500, "Map-Board"];
lbAdd [1500, "Chair Plastic"];
lbAdd [1500, "Desk"];
lbAdd [1500, "Shelves"];
lbAdd [1500, "Wooden Table"];
lbAdd [1500, "Camping Lantern"];
lbAdd [1500, "Camping Table"];
lbAdd [1500, "Camping Chair"];
lbAdd [1500, "Sink"];
lbAdd [1500, "Field Toilet"];
if (isNil"IFENABLED") then {
lbAdd [1500, "PortableLight S"];
lbAdd [1500, "PortableLight D"];
lbAdd [1500, "Power Generator"];
};
};
case "AI Guards": {
lbAdd [1500, "AA-Guard"];
lbAdd [1500, "AT-Guard"];
lbAdd [1500, "MG-Guard"];
lbAdd [1500, "Sniper-Guard"];
lbAdd [1500, "Medic-Guard"];
};
case "AI Weapons": {
lbAdd [1500, "AT-Launcher"];
lbAdd [1500, "AA-Launcher"];
lbAdd [1500, "HMG-weapon"];
lbAdd [1500, "HMG-weapon (High)"];
lbAdd [1500, "HMG-weapon (A)"];
lbAdd [1500, "GMG-weapon"];
lbAdd [1500, "GMG-weapon (High)"];
lbAdd [1500, "GMG-weapon (A)"];
lbAdd [1500, "Mortar"];
};
case "AI Vehicles": {
lbAdd [1500, "Armored AA (Static)"];
lbAdd [1500, "Tank (Static)"];
lbAdd [1500, "GL-Vehicle (Static)"];
lbAdd [1500, "MG-Vehicle (Static)"];
lbAdd [1500, "Armoded GL-Vehicle (Static)"];
};
};
[] CALL SAOKCONSITEM;
};