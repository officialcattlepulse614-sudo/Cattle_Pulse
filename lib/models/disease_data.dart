class Disease {
  final String name;
  final List<String> symptoms;
  final List<String> cureSteps;
  final bool needsVet;

  Disease({
    required this.name,
    required this.symptoms,
    required this.cureSteps,
    required this.needsVet,
  });
}

// 🩺 Updated and Expanded Cattle Diseases Data (2025)
final List<Disease> cattleDiseases = [
  // 🐄 Mastitis
  Disease(
    name: "Mastitis",
    symptoms: [
      "Swelling and redness in udder",
      "Clotted or watery milk",
      "Pain during milking",
      "Decreased milk production"
    ],
    cureSteps: [
      "Clean the udder with warm antiseptic water.",
      "Inject antibiotics as prescribed by a veterinarian.",
      "Ensure proper milking hygiene.",
      "Keep animal’s bedding dry and clean."
    ],
    needsVet: true,
  ),

  // 🦠 Foot and Mouth Disease (FMD)
  Disease(
    name: "Foot and Mouth Disease (FMD)",
    symptoms: [
      "Blisters in mouth, tongue, and hooves",
      "Drooling saliva",
      "Loss of appetite",
      "Lameness and fever"
    ],
    cureSteps: [
      "Isolate infected animal immediately.",
      "Disinfect barn using phenol solution.",
      "Feed soft and clean food.",
      "Vaccinate herd every 6 months under veterinary supervision."
    ],
    needsVet: true,
  ),

  // 💨 Bloat
  Disease(
    name: "Bloat",
    symptoms: [
      "Swelling on the left side of abdomen",
      "Difficulty breathing",
      "Restlessness",
      "Frequent lying down and getting up"
    ],
    cureSteps: [
      "Stop feeding concentrates immediately.",
      "Massage left abdomen to release gas.",
      "Provide vegetable oil or sodium bicarbonate solution.",
      "If severe, call a vet for trocar insertion."
    ],
    needsVet: false,
  ),

  // 🧫 Brucellosis
  Disease(
    name: "Brucellosis",
    symptoms: [
      "Abortion during late pregnancy",
      "Infertility and retained placenta",
      "Reduced milk yield"
    ],
    cureSteps: [
      "Isolate affected animals.",
      "Burn or bury aborted materials safely.",
      "Do not consume raw milk from infected animals.",
      "Vaccinate young heifers and bulls under veterinary guidance."
    ],
    needsVet: true,
  ),

  // ☠️ Anthrax
  Disease(
    name: "Anthrax",
    symptoms: [
      "Sudden death without warning",
      "Bloody discharge from nostrils and anus",
      "Swelling under throat and abdomen"
    ],
    cureSteps: [
      "Do not open carcass of suspected animals.",
      "Disinfect and bury carcass under veterinary supervision.",
      "Burn contaminated feed and bedding.",
      "Vaccinate remaining herd as preventive measure."
    ],
    needsVet: true,
  ),

  // 🌡️ Lumpy Skin Disease (LSD)
  Disease(
    name: "Lumpy Skin Disease (LSD)",
    symptoms: [
      "Firm nodules on skin and neck area",
      "Fever and loss of appetite",
      "Discharge from eyes and nose",
      "Swelling of legs or udder"
    ],
    cureSteps: [
      "Isolate infected animal immediately.",
      "Clean lesions with antiseptic.",
      "Apply antibiotic cream to prevent secondary infection.",
      "Vaccinate herd annually (Neethling strain vaccine)."
    ],
    needsVet: true,
  ),

  // 🪰 Trypanosomiasis (Surra)
  Disease(
    name: "Trypanosomiasis (Surra)",
    symptoms: [
      "Fever and weakness",
      "Weight loss and anemia",
      "Swelling under the jaw",
      "Watery eyes and nose"
    ],
    cureSteps: [
      "Inject trypanocidal drugs (e.g., Berenil, Trypamidium).",
      "Reduce fly population with insecticides.",
      "Provide iron-rich supplements and vitamin B complex.",
      "Consult a vet for dosage and repeat intervals."
    ],
    needsVet: true,
  ),

  // 🧬 Theileriosis
  Disease(
    name: "Theileriosis",
    symptoms: [
      "High fever and swollen lymph nodes",
      "Anemia and weakness",
      "Decreased milk yield",
      "Yellowish eyes and urine"
    ],
    cureSteps: [
      "Inject Buparvaquone (as prescribed by vet).",
      "Treat ticks with acaricides (cypermethrin).",
      "Keep animal in shade and hydrated.",
      "Regularly control ticks to prevent reinfection."
    ],
    needsVet: true,
  ),

  // 🦠 Black Quarter (BQ)
  Disease(
    name: "Black Quarter (BQ)",
    symptoms: [
      "Swelling in thigh, shoulder, or neck",
      "Crackling sound when pressed",
      "Fever and loss of appetite",
      "Lameness and sudden death"
    ],
    cureSteps: [
      "Isolate infected animal.",
      "Inject penicillin or prescribed antibiotics immediately.",
      "Disinfect stable and affected area.",
      "Vaccinate herd annually to prevent outbreaks."
    ],
    needsVet: true,
  ),

  // 🦠 Pneumonia
  Disease(
    name: "Pneumonia",
    symptoms: [
      "Labored breathing and nasal discharge",
      "Coughing and fever",
      "Loss of appetite",
      "Weakness and depression"
    ],
    cureSteps: [
      "Keep animal warm and away from cold wind.",
      "Administer broad-spectrum antibiotics (vet prescribed).",
      "Provide clean dry bedding and adequate ventilation.",
      "Monitor breathing rate regularly."
    ],
    needsVet: true,
  ),

  // 🦠 Diarrhea (Scours)
  Disease(
    name: "Diarrhea (Scours)",
    symptoms: [
      "Loose watery stool",
      "Dehydration and weakness",
      "Sunken eyes and dry nose",
      "Loss of appetite"
    ],
    cureSteps: [
      "Provide oral rehydration salts (ORS) immediately.",
      "Feed boiled rice water or electrolyte solutions.",
      "Give probiotics or multivitamins.",
      "If persistent, consult vet for antibiotic therapy."
    ],
    needsVet: false,
  ),

  // 🪱 Worm Infestation
  Disease(
    name: "Worm Infestation",
    symptoms: [
      "Weight loss and rough coat",
      "Diarrhea or constipation",
      "Swollen abdomen",
      "Low milk yield"
    ],
    cureSteps: [
      "Deworm animals using Albendazole or Fenbendazole (vet dosage).",
      "Clean grazing area and remove manure regularly.",
      "Provide mineral mixture and clean water.",
      "Repeat deworming every 3 months."
    ],
    needsVet: false,
  ),

  // 🦠 Johne’s Disease (Paratuberculosis)
  Disease(
    name: "Johne’s Disease (Paratuberculosis)",
    symptoms: [
      "Chronic diarrhea without blood",
      "Progressive weight loss",
      "Decreased milk production",
      "Normal appetite despite weight loss"
    ],
    cureSteps: [
      "Isolate affected animal.",
      "Provide highly nutritious feed and water.",
      "No specific cure — focus on herd testing and culling infected animals.",
      "Vaccination may help in prevention."
    ],
    needsVet: true,
  ),

  // 🦠 Ketosis
  Disease(
    name: "Ketosis",
    symptoms: [
      "Reduced feed intake",
      "Fruity odor in breath",
      "Low milk yield",
      "Unsteady movement"
    ],
    cureSteps: [
      "Feed molasses or glucose-based supplements.",
      "Provide propylene glycol orally for 3–5 days.",
      "Ensure balanced high-energy diet post-calving.",
      "Consult vet for IV glucose infusion if severe."
    ],
    needsVet: true,
  ),
];
