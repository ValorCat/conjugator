
local verb_data = {
	-- present indicative
	pres = {
		ar = {yo = "o", tu = "as", ud = "a", nos = "amos", vos = "áis", uds = "an"};
		er = {tu = "es", ud = "e", nos = "emos", vos = "éis", uds = "en"};
		ir = {nos = "imos", vos = "ís"};
		raw = {
			caber = {yo = "quepo"};
			dar = {yo = "doy", vos = "dais"};
			estar = {yo = "estoy", tu = "estás", ud = "está", uds = "están"};
			hacer = {yo = "hago"};
			ir = {yo = "voy", tu = "vas", ud = "va", nos = "vamos", vos = "vais", uds = "van"};
			saber = {yo = "sé"};
			ser = {yo = "soy", tu = "eres", ud = "es", nos = "somos", vos = "sois", uds = "son"};
			ver = {yo = "veo"}; };
		go = {"caer", "poner", "salir", "tener", "traer", "valer", "venir"}; };
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
	pres = {"pres", "present", "presente"};
	pret = {"pret", "past", "pasado", "preterit", "preterite", "preterito", "pretérito"};
	imp = {"imp", "imperfect", "imperfecto"};
	fut = {"fut", "future", "futuro"};
	con = {"con", "cond", "conditional", "condicional"};
	subj = {"sub", "subj", "subjunctive", "subjunctivo"}; }

-- replaces accented chars with normal counterparts
local function noacc(str)
	local accents = {["á"] = "a", ["é"] = "e", ["í"] = "i", ["ó"] = "o", ["ú"] = "u", ["ü"] = "u"}
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

print("Enter a tense:")
local tense = io.read()

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

print("Enter a verb:")
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

-- handle 'go' verbs
if lookup.go then
	for _, item in pairs(lookup.go) do
		if verb == item then
			if ctype(verb:sub(-3, -3)) == "consonant" then
				table.yo = verb:sub(1, -3) .. "go"
			else
				table.yo = verb:sub(1, -3) .. "igo"
			end
		end
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
