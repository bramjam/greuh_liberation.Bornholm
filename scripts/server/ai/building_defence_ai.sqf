params [ "_unit" ];
private [ "_move_is_disabled", "_hostilecount", "_targett" ];
_unit setUnitPos "UP";
_unit disableAI "MOVE";
_move_is_disabled = true;

while { _move_is_disabled && local _unit && alive _unit && !(captive _unit) } do {
	_hostilecount = { alive _x && side _x == WEST } count ( (getpos _unit) nearEntities [ ["Man"], 15 ] );

	if ( _hostilecount > 0 || ( damage _unit > 0.25 ) ) then {
		if ( _move_is_disabled ) then {
			_move_is_disabled = false;
			_unit enableAI "MOVE";
			_unit setUnitPos "AUTO";
		}
	};

	if ( _move_is_disabled ) then {
		_targett = assignedTarget _unit;
		if(!(isnull _targett)) then {
			_vd2 = (getPosASL _targett) vectorDiff (getpos _unit);
			_newdir2 = (_vd2 select 0) atan2 (_vd2 select 1);
			if (_newdir2 < 0) then {_dir = 360 + _newdir2 };
			_unit setdir (_newdir2);
		};
	};

	sleep 1;

};