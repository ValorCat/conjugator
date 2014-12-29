
local verb_data = {
	-- present indicative
	pres = {
		ar = {yo = "o", tu = "as", ud = "a", nos = "amos", vos = "áis", uds = "an"};
		er = {tu = "es", ud = "e", nos = "emos", vos = "éis", uds = "en"};
		ir = {nos = "imos", vos = "ís"};
		raw = {
			caber = {yo = "quepo"};
			dar = {yo = "doy", vos = "dais"};
			decir = {yo = "digo", tu = "dices", ud = "dice", uds = "dicen"};
			estar = {yo = "estoy", tu = "estás", ud = "está", uds = "están"};
			hacer = {yo = "hago"};
			ir = {yo = "voy", tu = "vas", ud = "va", nos = "vamos", vos = "vais", uds = "van"};
			saber = {yo = "sé"};
			ser = {yo = "soy", tu = "eres", ud = "es", nos = "somos", vos = "sois", uds = "son"};
			servir = {yo = "sirvo", tu = "sirves", ud = "sirve", uds = "sirven"};
			ver = {yo = "veo"};
			vestir = {yo = "visto", tu = "vistes", ud = "viste", uds = "visten"}; };
		stem = {"acertar", "acordar", "acostar", "advertir", "almorzar", "aprobar", "atender", "atraversar", "calentar", "cerrar", "colgar", "comenzar", "competir",  "confesar", "contar", "convertir", "costar", "defender", "demostrar", "despedir", "despertar", "devolver", "divertir", "dormir", "empezar", "encender", "encontrar", "entender", "enterrar", "envolver", "fregar", "forzar", "herir", "hervir", "impedir", "medir", "mentir", "merendar", "morder", "morir", "mostrar", "mover", "negar",  "pedir", "pensar", "perder", "poder", "preferir", "probar", "querer", "recordar", "regar", "repetir", "resolver", "rogar", "soler", "sonar", "soñar", "sugerir", "temblar", "tender", "tener", "tropezar", "venir", "verter"};
		go = {"caer", "poner", "salir", "tener", "tostar", "traer", "valer", "venir", "volar", "volver"}; };
	-- past preterite
	pret = {
		ar = {yo = "é", tu = "aste", ud = "ó", nos = "amos", vos = "asteis", uds = "aron"};
		er = {yo = "í", tu = "iste", ud = "ió", nos = "imos", vos = "isteis", uds = "ieron"};
		ir = {}; };
	-- past imperfect
	imp = {
		ar = {yo = "aba", tu = "abas", ud = "aba", nos = "abamos", vos = "abais", uds = "aban"};
		er = {yo = "ía", tu = "ías", ud = "ía", nos = "íamos", vos = "íais", uds = "ían"};
		ir = {}; };
	-- future indicative
	fut = {
		ar = {yo = "é", tu = "ás", ud = "á", nos = "emos", vos = "éis", uds = "án"};
		er = {};
		ir = {};
		use_inf = true; };
	-- conditional
	con = {
		ar = {yo = "ía", tu = "ías", ud = "ía", nos = "íamos", vos = "íais", uds = "ían"};
		er = {};
		ir = {};
		use_inf = true; };
	-- present subjunctive
	subj = {
		ar = {yo = "e", tu = "es", ud = "e", nos = "emos", vos = "éis", uds = "en"};
		er = {yo = "a", tu = "as", ud = "a", nos = "amos", vos = "áis", uds = "an"};
		ir = {}; }; }

local tenses = {
	pres = {"", "pres", "present", "presente"};
	pret = {"p", "pret", "past", "pasado", "preterit", "preterite", "preterito", "pretérito"};
	imp = {"i", "imp", "imperfect", "imperfecto"};
	fut = {"f", "fut", "future", "futuro"};
	con = {"c", "con", "cond", "conditional", "condicional"};
	subj = {"s", "sub", "subj", "subjunctive", "subjunctivo"}; }

-- replaces accented chars with normal counterparts
local function noacc(str)
	local accents = {["á"] = "a", ["é"] = "e", ["í"] = "i", ["ñ"] = "n", ["ó"] = "o", ["ú"] = "u", ["ü"] = "u"}
	return (str:gsub("(%a)", accents))
end	

-- returns consonant, vowel, or symbol
local function ctype(char)
	if not char:find("%a") then
		return "symbol"
	else
		char = noacc(char)
		for _, vowel in pairs({"a", "e", "i", "o", "u"}) do
			if char == vowel then
				return "vowel"
			end
		end
		return "consonant"
	end
end

-- searchs for item in array
local function contains(tab, itm)
	if type(tab) == "table" then
		for _, val in pairs(tab) do
			if itm == val then
				return true
			end
		end
	end
	return false
end

print("")
io.write("Enter a tense: ")
local tense = io.read()
print("")

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
	print("Invalid tense!")
	return false
end
local lookup = verb_data[tense]

while 1 do
	io.write("Enter a verb: ")
	local verb = io.read()
	local verb_type = noacc(verb:sub(-2)) -- 'ar', 'er', or 'ir'
	local table = {}

	-- accommodate the future and conditional's use of infinitive
	local root = verb:sub(1, -3)
	if lookup.use_inf then
		root = verb
	end

	-- get default suffix
	for _, form in pairs({"yo", "tu", "ud", "nos", "vos", "uds"}) do
		
		-- inheritance ('ir' defaults to 'er' defaults to 'ar')
		local continue = false
		for _, current in pairs({"ir", "er", "ar"}) do
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

	-- pres: default, stem, go

	-- handle stem changers (eg pensar -> piensa)
	if contains(lookup.stem, verb) then
		local change = {"e", "ie"}
		
		-- if ending in 'edir' or 'etir'
		if (verb:sub(-4) == "edir") or (verb:sub(-4) == "etir") then
			change[2] = "i"
		end
		
		-- if penultimate vowel is 'o'
		for i = #root, 1, -1 do
			local char = verb:sub(i, i)
			if ctype(char) == "vowel" then
				if char == "o" then
					change = {"o", "ue"}
				end
				break
			end
		end
		
		-- change the stem
		for _, form in pairs({"yo", "tu", "ud", "uds"}) do
			local repl = root:reverse():gsub(change[1]:reverse(), change[2]:reverse(), 1):reverse()
			table[form] = table[form]:gsub(root, repl)
		end
	end		

	-- handle 'go' verbs
	if contains(lookup.go, verb) then
		if ctype(root:sub(-1)) == "consonant" then
			table.yo = root .. "go"
		else
			table.yo = root .. "igo"
		end
	end

	-- handle a full replace (eg ser in present tense)
	for form in pairs(table) do
		if lookup.raw[verb] then
			table[form] = lookup.raw[verb][form] or table[form]
		end
	end

	print("")
	print(table.yo, " " .. table.nos)
	print(table.tu, " " .. table.vos)
	print(table.ud, " " .. table.uds)
	print("")
end
