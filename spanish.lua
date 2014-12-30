
local verb_data = {
	-- present indicative
	pres = {
		ar = {yo = 'o', tu = 'as', ud = 'a', nos = 'amos', vos = 'áis', uds = 'an'};
		er = {tu = 'es', ud = 'e', nos = 'emos', vos = 'éis', uds = 'en'};
		ir = {nos = 'imos', vos = 'ís'};
		stem = 'full';
		guir = true;
		yrule = 'full';
		zrule = true;
		raw = {
			caber = {yo = 'quepo'};
			dar = {yo = 'doy', vos = 'dais'};
			decir = {yo = 'digo', tu = 'dices', ud = 'dice', uds = 'dicen'};
			estar = {yo = 'estoy', tu = 'estás', ud = 'está', uds = 'están'};
			hacer = {yo = 'hago'};
			ir = {yo = 'voy', tu = 'vas', ud = 'va', nos = 'vamos', vos = 'vais', uds = 'van'};
			jugar = {yo = 'juego', tu = 'juegas', ud = 'juega', uds = 'juegan'};
			mecer = {yo = 'mezco'};
			saber = {yo = 'sé'};
			ser = {yo = 'soy', tu = 'eres', ud = 'es', nos = 'somos', vos = 'sois', uds = 'son'};
			servir = {yo = 'sirvo', tu = 'sirves', ud = 'sirve', uds = 'sirven'};
			ver = {yo = 'veo'};
			vestir = {yo = 'visto', tu = 'vistes', ud = 'viste', uds = 'visten'}; };
		go = {'caer', 'poner', 'salir', 'tener', 'tostar', 'traer', 'valer', 'venir', 'volar', 'volver'}; };
	-- past preterite
	pret = {
		ar = {yo = 'é', tu = 'aste', ud = 'ó', nos = 'amos', vos = 'asteis', uds = 'aron'};
		er = {yo = 'í', tu = 'iste', ud = 'ió', nos = 'imos', vos = 'isteis', uds = 'ieron'};
		ir = {};
		rr = {yo = 'e', tu = 'iste', ud = 'o', nos = 'imos', vos = 'isteis', uds = 'ieron'};
		yir = {yo = 'í', tu = 'íste', ud = 'yó', nos = 'ímos', vos = 'ísteis', uds = 'yeron'};
		stem = 'partial';
		yrule = 'partial';
		cgz = true;
		root = {andar = 'anduv', caber = 'cup', dar = 'd', haber = 'hub', hacer = 'hic', ir = 'fu', estar = 'estuv', poder = 'pud', poner = 'pus', querer = 'quis', saber = 'sup', ser = 'fu', tener = 'tuv', venir = 'vin'};
		raw = {
			dar = {yo = 'di', ud = 'dio'};
			hacer = {ud = 'hizo'}; 
			ir = {yo = 'fui', ud = 'fue'}; 
			ser = {yo = 'fui', ud = 'fue'}; }; };
	-- past imperfect
	imp = {
		ar = {yo = 'aba', tu = 'abas', ud = 'aba', nos = 'abamos', vos = 'abais', uds = 'aban'};
		er = {yo = 'ía', tu = 'ías', ud = 'ía', nos = 'íamos', vos = 'íais', uds = 'ían'};
		ir = {};
		raw = {
			ir = {yo = 'iba', tu = 'ibas', ud = 'iba', nos = 'ibamos', vos = 'ibais', uds = 'iban'};
			ser = {yo = 'era', tu = 'eras', ud = 'era', nos = 'eramos', vos = 'erais', uds = 'eran'}; 
			ver = {yo = 'veía', tu = 'veías', ud = 'veía', nos = 'veíamos', vos = 'veíais', uds = 'veían'}; }; };
	-- future indicative
	fut = {
		ar = {yo = 'é', tu = 'ás', ud = 'á', nos = 'emos', vos = 'éis', uds = 'án'};
		er = {};
		ir = {};
		use_inf = true;
		root = {caber = 'cabr', decir = 'dir', haber = 'habr', hacer = 'har', poder = 'podr', poner = 'pondr', querer = 'quierr', saber = 'sabr', salir = 'saldr', tener = 'tendr', valer = 'valdr', venir = 'vendr'}; };
	-- conditional
	con = {
		ar = {yo = 'ía', tu = 'ías', ud = 'ía', nos = 'íamos', vos = 'íais', uds = 'ían'};
		er = {};
		ir = {};
		use_inf = true; };
	-- present subjunctive
	subj = {
		ar = {yo = 'e', tu = 'es', ud = 'e', nos = 'emos', vos = 'éis', uds = 'en'};
		er = {yo = 'a', tu = 'as', ud = 'a', nos = 'amos', vos = 'áis', uds = 'an'};
		ir = {}; }; }

local stem = {'acertar', 'acordar', 'acostar', 'advertir', 'almorzar', 'aprobar', 'atender', 'atraversar', 'calentar', 'cerrar', 'colegir', 'colgar', 'comenzar', 'competir',  'confesar', 'conseguir', 'contar', 'convertir', 'corregir', 'costar', 'defender', 'demostrar', 'despedir', 'despertar', 'devolver', 'divertir', 'dormir', 'elegir', 'empezar', 'encender', 'encontrar', 'entender', 'enterrar', 'envolver', 'fregar', 'forzar', 'herir', 'hervir', 'impedir', 'medir', 'mentir', 'merendar', 'morder', 'morir', 'mostrar', 'mover', 'negar',  'pedir', 'pensar', 'perder', 'perseguir', 'poder', 'preferir', 'probar', 'querer', 'recordar', 'regar', 'repetir', 'resolver', 'rogar', 'seguir', 'soler', 'sonar', 'soñar', 'sugerir', 'temblar', 'tender', 'tener', 'tropezar', 'venir', 'verter'}

local tenses = {
	pres = {' ', 'pres', 'present', 'presente', 'present indicative'};
	pret = {'p', 'pret', 'past', 'pasado', 'preterit', 'preterite', 'preterito', 'pretérito', 'past perfect indicative'};
	imp = {'i', 'imp', 'imperfect', 'imperfecto', 'past imperfect indicative'};
	fut = {'f', 'fut', 'future', 'futuro', 'future indicative'};
	con = {'c', 'con', 'cond', 'conditional', 'condicional', 'conditional mode'};
	subj = {'s', 'sub', 'subj', 'subjunctive', 'subjunctivo', 'present subjunctive'}; }

-- replaces accented chars with normal counterparts
local function noacc(str)
	local accents = {['á'] = 'a', ['é'] = 'e', ['í'] = 'i', ['ñ'] = 'n', ['ó'] = 'o', ['ú'] = 'u', ['ü'] = 'u'}
	return (str:gsub('(%a)', accents))
end	

-- returns consonant, vowel, or symbol
local function ctype(char)
	if not char:find('%a') then
		return 'symbol'
	else
		char = noacc(char)
		for _, vowel in pairs({'a', 'e', 'i', 'o', 'u'}) do
			if char == vowel then
				return 'vowel'
			end
		end
		return 'consonant'
	end
end

-- searchs for item in array
local function contains(tab, itm)
	if type(tab) == 'table' then
		for _, val in pairs(tab) do
			if itm == val then
				return true
			end
		end
	end
	return false
end

-- string.gsub, but works from the end back
local function gsubrev(str, patt, repl, num)
	str = str:reverse()
	patt = patt:reverse()
	repl = repl:reverse()
	return str:gsub(patt, repl, num):reverse()
end

-- verifies input ends with given substring
local function suffix(str, ...)
	for _, suff in ipairs({...}) do
		if str:sub(0 - #suff) == suff then
			return true
		end
	end
	return false
end

while true do
	local skip = false
	
	-- get the tense/mood
	io.write('\nEnter a tense: ')
	local raw_tense = io.read()
	local forms = {}

	-- verify tense
	do
		if raw_tense == "" then
			break
		end
		
		local found = false
		for internal, list in pairs(tenses) do
			for _, possible in pairs(list) do
				if raw_tense == possible then
					raw_tense = internal
					found = true
				end
			end
		end
		
		if not found then
			print('Unknown tense!')
			skip = true
		end
	end
	
	if not skip then
		local tense = verb_data[raw_tense]
		print(string.format('Using: %s\n', tenses[raw_tense][#tenses[raw_tense]]))
		print('Enter a verb:')
		while true do
			
			skip = false
			io.write(' :: ')
			local verb = io.read()
			if verb == '' then
				break
			end
			
			-- check if reflexive
			local reflex = false
			if verb:sub(-3) == 'rse' then
				verb = verb:sub(1, -3)
				reflex = true
			end
			
			-- verify verb is in infinitive
			local verb_type = noacc(verb:sub(-2)) -- 'ar', 'er', or 'ir'
			if (verb_type ~= 'ar') and (verb_type ~= 'er') and (verb_type ~= 'ir') then
				print('Verb must be in the infinitive!\n')
				skip = true
			end
			
			-- conjugate!
			if not skip then
				
				-- accommodate the future and conditional's use of infinitive
				local root = verb:sub(1, -3)
				if tense.use_inf then
					root = verb
				end

				-- get root and default suffix
				for _, form in pairs({'yo', 'tu', 'ud', 'nos', 'vos', 'uds'}) do
					
					-- inheritance ('ir' defaults to 'er' defaults to 'ar')
					local continue = false
					for _, current in pairs({'ir', 'er', 'ar'}) do
						if (current == verb_type) or continue then
							
							-- search for the suffix in current subtable
							local conj = tense[current][form]
							
							-- if it is defined here, use it
							if conj then
								forms[form] = root .. conj
								continue = false
							
							-- if it is not defined here, default to the next subtable
							else
								continue = true
							end
						end
					end
				end

				-- handle stem changers (eg pres. pensar -> piensa)
				if tense.stem and contains(stem, verb) then
					
					-- present tense (e->ie, e->i, o->ue)
					if tense.stem == 'full' then
						local change = {'e', 'ie'}
						
						-- if ending in 'edir', 'etir', or 'eguir'
						if suffix(verb, 'edir', 'etir', 'eguir') then
							change = {'e', 'i'}
						end
						
						-- if penultimate vowel is 'o'
						for i = #root, 1, -1 do
							local char = verb:sub(i, i)
							if ctype(char) == 'vowel' then
								if char == 'o' then
									change = {'o', 'ue'}
								end
								break
							end
						end
						
						-- change the stem
						for _, form in pairs({'yo', 'tu', 'ud', 'uds'}) do
							local repl = gsubrev(root, change[1], change[2], 1)
							forms[form] = forms[form]:gsub(root, repl)
						end
					
					-- preterite (e->i, o->u)
					elseif (tense.stem == 'partial') and (verb_type == 'ir') then
						local change = {'e', 'i'}
						
						-- if penultimate vowel is 'o'
						for i = #root, 1, -1 do
							local char = verb:sub(i, i)
							if ctype(char) == 'vowel' then
								if char == 'o' then
									change = {'o', 'u'}
								end
								break
							end
						end
						
						-- change the stem
						local repl = gsubrev(root, change[1], change[2], 1)
						forms.ud = forms.ud:gsub(root, repl)
						forms.uds = forms.ud:gsub(root, repl)
					end
				end		
				
				-- handle root changers (eg pret. tener -> tuvo, fut. haber -> habrá)
				if tense.root then
					local endings = tense.rr or tense.ar
					if tense.root[verb] then
						for form in pairs(forms) do
							forms[form] = tense.root[verb] .. endings[form]
						end
					end
				end
				
				-- handle 'go' verbs (eg pres. tener)
				if contains(tense.go, verb) then
					if ctype(root:sub(-1)) == 'consonant' then
						forms.yo = root .. 'go'
					else
						forms.yo = root .. 'igo'
					end
				end
				
				-- handle car, gar, zar (eg pret. jugar)
				if tense.cgz and suffix(verb, 'car', 'gar', 'zar') then
					local char = verb:sub(-3, -3)
					local suff = tense.ar.yo
					local change = {'c', 'qu'}
					if char == 'g' then
						change = {'g', 'gu'}
					elseif char == 'z' then
						change = {'z', 'c'}
					end
					forms.yo = gsubrev(forms.yo, change[1] .. suff, change[2] .. suff, 1)
				end
				
				-- handle g -> j (eg pres. escoger)
				if suffix(forms.yo, 'go') and suffix(verb, 'ger', 'gir') then
					forms.yo = gsubrev(forms.yo, 'go', 'jo', 1)
				end
				
				-- handle gu -> g (eg pres. seguir)
				if tense.guir and suffix(verb, 'guir') then
					forms.yo = gsubrev(forms.yo, 'guo', 'go', 1)
				end
				
				-- handle adding 'y' (eg pres. incluir, pret. creer)
				if tense.yrule then
					
					-- add 'y' before a, e, and o
					if (tense.yrule == 'full') and (suffix(verb, 'uir') and not suffix(verb, 'guir')) then
						for form in pairs(forms) do
							forms[form] = forms[form]:gsub('u([aeo])', 'uy%1', 1)
						end
					
					-- add 'y' in both 3rd person forms
					elseif (tense.yrule == 'partial') then
						
						-- just add 'y'
						if suffix(verb, 'uir') then
							forms.ud = forms.ud:gsub(tense.er.ud, tense.yir.ud)
							forms.uds = forms.uds:gsub(tense.er.uds, tense.yir.uds)
						
						-- add accents to forms without 'y'
						elseif (suffix(verb, 'aer') and (verb ~= 'traer')) or suffix(verb, 'eer') or suffix(verb, 'oir') or suffix(verb, 'oír') or suffix(verb, 'oer') then
							for form in pairs(tense.yir) do
								forms[form] = forms[form]:gsub(tense.er[form], tense.yir[form])
							end
						end
					end
				end
				
				-- handle the z rule (eg pres. conocer)
				if tense.zrule and suffix(verb, 'cer', 'cir') then
					local chartype = ctype(verb:sub(-4, -4))
					if chartype == 'consonant' then
						forms.yo = gsubrev(forms.yo, 'c', 'z', 1)
					elseif (chartype == 'vowel') and (verb ~= 'decir') and (verb ~= 'hacer') then
						forms.yo = gsubrev(forms.yo, 'c', 'zc', 1)
					end
				end
				
				-- handle full replaces (eg pres. ser)
				if tense.raw then
					for form in pairs(forms) do
						if tense.raw[verb] then
							forms[form] = tense.raw[verb][form] or forms[form]
						end
					end
				end
				
				-- add reflexive pronouns
				if reflex then
					local pronouns = {yo = 'me', tu = 'te', ud = 'se', nos = 'nos', vos = 'os', uds = 'se'}
					for form in pairs(forms) do
						forms[form] = string.format('%s %s', pronouns[form], forms[form])
					end
				end
				
				-- ensure alignment of forms (console automoves column if more than 7 chars)
				if (#forms.yo > 7) or (#forms.tu > 7) or (#forms.ud > 7) then
					for _, entry in pairs({'yo', 'tu', 'ud'}) do
						forms[entry] = forms[entry] .. string.rep(' ', 9 - #forms[entry])
					end
				end
				
				-- display the finished verb chart
				do
					print('')
					print(forms.yo, forms.nos)
					print(forms.tu, forms.vos)
					print(forms.ud, forms.uds)
					print('')
				end
			end
		end
	end
end

print('')
