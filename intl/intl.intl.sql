-- FIDATA. Open-source system for analysis of financial and economic data
-- Copyright © 2013  Basil Peace

/*
   This file is part of FIDATA.

   FIDATA is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   FIDATA is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with FIDATA.  If not, see <http://www.gnu.org/licenses/>.
*/


CREATE TABLE langs_representations (
	lang common.lang_id NOT NULL
		REFERENCES langs (id)
			ON UPDATE CASCADE ON DELETE CASCADE,
	script common.script_id
		REFERENCES scripts (id)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CHECK (is_valid_lang_script(lang, script)),
	obj common.lang_id NOT NULL
		REFERENCES langs (id)
			ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (lang, script, obj),
	
	representation character varying(32) NOT NULL
		CHECK (char_length(representation) > 0)
);
CREATE INDEX ON langs_representations (script);
CREATE INDEX ON langs_representations (obj);
CREATE UNIQUE INDEX ON langs_representations (lang, script, upper(representation));


CREATE TABLE scripts_representations (
	lang common.lang_id NOT NULL
		REFERENCES langs (id)
			ON UPDATE CASCADE ON DELETE CASCADE,
	script common.script_id
		REFERENCES scripts (id)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CHECK (is_valid_lang_script(lang, script)),
	obj common.script_id NOT NULL
		REFERENCES scripts (id)
			ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (lang, script, obj),
	
	representation character varying(32) NOT NULL
		CHECK (char_length(representation) > 0)
);
CREATE INDEX ON scripts_representations (script);
CREATE INDEX ON scripts_representations (obj);
CREATE UNIQUE INDEX ON scripts_representations (lang, script, upper(representation));
