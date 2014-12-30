
local verb_data = {
	-- present indicative
	pres = {
		ar = {yo = 'o', tu = 'as', ud = 'a', nos = 'amos', vos = 'áis', uds = 'an'};
		er = {tu = 'es', ud = 'e', nos = 'emos', vos = 'éis', uds = 'en'};
		ir = {nos = 'imos', vos = 'ís'};
		guir = true;
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
		stem = {'acertar', 'acordar', 'acostar', 'advertir', 'almorzar', 'aprobar', 'atender', 'atraversar', 'calentar', 'cerrar', 'colegir', 'colgar', 'comenzar', 'competir',  'confesar', 'conseguir', 'contar', 'convertir', 'corregir', 'costar', 'defender', 'demostrar', 'despedir', 'despertar', 'devolver', 'divertir', 'dormir', 'elegir', 'empezar', 'encender', 'encontrar', 'entender', 'enterrar', 'envolver', 'fregar', 'forzar', 'herir', 'hervir', 'impedir', 'medir', 'mentir', 'merendar', 'morder', 'morir', 'mostrar', 'mover', 'negar',  'pedir', 'pensar', 'perder', 'perseguir', 'poder', 'preferir', 'probar', 'querer', 'recordar', 'regar', 'repetir', 'resolver', 'rogar', 'seguir', 'soler', 'sonar', 'soñar', 'sugerir', 'temblar', 'tender', 'tener', 'tropezar', 'venir', 'verter'};
		go = {'caer', 'poner', 'salir', 'tener', 'tostar', 'traer', 'valer', 'venir', 'volar', 'volver'}; };
	-- past preterite
	pret = {
		ar = {yo = 'é', tu = 'aste', ud = 'ó', nos = 'amos', vos = 'asteis', uds = 'aron'};
		er = {yo = 'í', tu = 'iste', ud = 'ió', nos = 'imos', vos = 'isteis', uds = 'ieron'};
		ir = {}; };
	-- past imperfect
	imp = {
		ar = {yo = 'aba', tu = 'abas', ud = 'aba', nos = 'abamos', vos = 'abais', uds = 'aban'};
		er = {yo = 'ía', tu = 'ías', ud = 'ía', nos = 'íamos', vos = 'íais', uds = 'ían'};
		ir = {}; };
	-- future indicative
	fut = {
		ar = {yo = 'é', tu = 'ás', ud = 'á', nos = 'emos', vos = 'éis', uds = 'án'};
		er = {};
		ir = {};
		use_inf = true; };
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

local tenses = {
	pres = {'', 'pres', 'present', 'presente'};
	pret = {'p', 'pret', 'past', 'pasado', 'preterit', 'preterite', 'preterito', 'pretérito'};
	imp = {'i', 'imp', 'imperfect', 'imperfecto'};
	fut = {'f', 'fut', 'future', 'futuro'};
	con = {'c', 'con', 'cond', 'conditional', 'condicional'};
	subj = {'s', 'sub', 'subj', 'subjunctive', 'subjunctivo'}; }

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

print('')
io.write('Enter a tense: ')
local tense = io.read()
print('')

-- verify tense
local found = false
for internal, list in pairs(tenses) do
	for _, possible in pairs(list) do
		if tense == possible then
			tense = internal
			found = true
		end
	end
end

-- exit on invalid tense
if not found then
	print('Invalid tense!')
	return false
end
local lookup = verb_data[tense]

while 1 do
	io.write('Enter a verb: ')
	local verb = io.read()
	local verb_type = noacc(verb:sub(-2)) -- 'ar', 'er', or 'ir'
	local table = {}
	
	-- verify verb is in infinitive
	if (verb_type ~= 'ar') and (verb_type ~= 'er') and (verb_type ~= 'ir') then
		print('Verb must be in the infinitive!')
		return false
	end
	
	-- accommodate the future and conditional's use of infinitive
	local root = verb:sub(1, -3)
	if lookup.use_inf then
		root = verb
	end

	-- get default suffix
	for _, form in pairs({'yo', 'tu', 'ud', 'nos', 'vos', 'uds'}) do
		
		-- inheritance ('ir' defaults to 'er' defaults to 'ar')
		local continue = false
		for _, current in pairs({'ir', 'er', 'ar'}) do
			if (current == verb_type) or continue then
				
				-- search for the suffix in current subtable
				local conj = lookup[current][form]
				
				-- if it is defined here, use it
				if conj then
					table[form] = root .. conj
					continue = false
				
				-- if it is not defined here, default to the next subtable
				else
					continue = true
				end
			end
		end
	end

	-- handle stem changers (eg pensar -> piensa)
	if contains(lookup.stem, verb) then
		local change = {'e', 'ie'}
		
		-- if ending in 'edir', 'etir', or 'eguir'
		if (verb:sub(-4) == 'edir') or (verb:sub(-4) == 'etir') or (verb:sub(-5) == 'eguir') then
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
			table[form] = table[form]:gsub(root, repl)
		end
	end		

	-- handle 'go' verbs
	if contains(lookup.go, verb) then
		if ctype(root:sub(-1)) == 'consonant' then
			table.yo = root .. 'go'
		else
			table.yo = root .. 'igo'
		end
	end
	
	-- handle g -> j (eg escoger)
	if (table.yo:sub(-2) == 'go') and ((verb:sub(-3) == 'ger') or (verb:sub(-3) == 'gir')) then
		table.yo = gsubrev(table.yo, 'go', 'jo', 1)
	end
	
	-- handle gu -> g (eg seguir)
	if lookup.guir and (verb:sub(-4) == 'guir') then
		table.yo = gsubrev(table.yo, 'guo', 'go', 1)
	end
	
	-- handle adding 'y' (eg incluir)
	if (verb:sub(-3) == 'uir') and (verb:sub(-4, -4) ~= 'g') then
		for form in pairs(table) do
			table[form] = table[form]:gsub('u([aeo])', 'uy%1', 1)
		end
	end
	
	-- handle the z rule (eg conocer)
	if lookup.zrule and ((verb:sub(-3) == 'cer') or (verb:sub(-3) == 'cir')) then
		local chartype = ctype(verb:sub(-4, -4))
		if chartype == 'consonant' then
			table.yo = gsubrev(table.yo, 'c', 'z', 1)
		elseif (chartype == 'vowel') and (verb ~= 'decir') and (verb ~= 'hacer') then
			table.yo = gsubrev(table.yo, 'c', 'zc', 1)
		end
	end
	
	-- handle full replaces (eg ser)
	if lookup.raw then
		for form in pairs(table) do
			if lookup.raw[verb] then
				table[form] = lookup.raw[verb][form] or table[form]
			end
		end
	end
	
	-- ensure alignment of forms (console automoves column if more than 7 chars)
	if (#table.yo > 7) or (#table.tu > 7) or (#table.ud > 7) then
		for _, entry in pairs({'yo', 'tu', 'ud'}) do
			table[entry] = table[entry] .. string.rep(' ', 8 - #table[entry])
		end
	end
	
	print('')
	print(table.yo, table.nos)
	print(table.tu, table.vos)
	print(table.ud, table.uds)
	print('')
end
