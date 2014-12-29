
local suffixes = {
	pres = { -- present indicative
		ar = {yo = "o", tu = "as", ud = "a", nos = "amos", vos = "áis", uds = "an"};
		er = {tu = "es", ud = "e", nos = "emos", vos = "éis", uds = "en"};
		ir = {nos = "imos", vos = "ís"};
		raw = {
			estar = {yo = "estoy", tu = "estás", ud = "está", uds = "están"};
			ser = {yo = "soy", tu = "eres", ud = "es", nos = "somos", vos = "sois", uds = "son"}; };
	}; pret = { -- past preterite
		ar = {yo = "é", tu = "aste", ud = "ó", nos = "amos", vos = "asteis", uds = "aron"};
		er = {yo = "í", tu = "iste", ud = "ió", nos = "imos", vos = "isteis", uds = "ieron"};
		ir = {};
	}; imp = { -- past imperfect
		ar = {yo = "aba", tu = "abas", ud = "aba", nos = "abamos", vos = "abais", uds = "aban"};
		er = {yo = "ía", tu = "ías", ud = "ía", nos = "íamos", vos = "íais", uds = "ían"};
		ir = {};
	}; fut = { -- future indicative
		ar = {yo = "é", tu = "ás", ud = "á", nos = "emos", vos = "éis", uds = "án"};
		er = {};
		ir = {};
		use_inf = true;
	}; con = { -- conditional
		ar = {yo = "ía", tu = "ías", ud = "ía", nos = "íamos", vos = "íais", uds = "ían"};
		er = {};
		ir = {};
		use_inf = true;
	}; subj = { -- present subjunctive
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
local lookup = suffixes[tense]

print("Enter a verb:")
local verb = io.read()
local verb_type = verb:sub(-2) -- 'ar', 'er', or 'ir'
local table = {}

-- get the default suffix
for _, form in pairs({"yo", "tu", "ud", "nos", "vos", "uds"}) do
	
	-- inheritance ('ir' defaults to 'er' defaults to 'ar')
	local continue = false
	for _, current in pairs({"ir", "er", "ar"}) do
		if (current == verb_type) or continue then
			
			-- search for the suffix in current subtable
			local conj = lookup[current][form]
			
			-- if it is defined here, use it
			if conj then
				table[form] = conj
				continue = false
			
			-- if it is not defined here, default to the next subtable
			else
				continue = true
			end
		end
	end
end

-- accomodate the future and conditional using the infinitive
local root = verb:sub(1, -3)
if lookup.use_inf then
	root = verb
end

-- change from the suffix to the full verb
for name, form in pairs(table) do
	table[name] = root .. table[name]
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
