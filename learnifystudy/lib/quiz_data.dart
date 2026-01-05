class Question {
  String questionText;
  List<String> options;
  int correctIndex;

  Question({required this.questionText, required this.options, required this.correctIndex});
}

class QuizData {
  // --- DATA STORAGE ---
  // Keys: "semIndex_chapterIndex"
  // Sem 0 = Semester 1 (Chapters 0-5)
  // Sem 1 = Semester 2 (Chapters 0-6)

  static final Map<String, List<Question>> _database = {

    // ===================================================
    // SEMESTER 1 (6 Chapters)
    // ===================================================

    // Chap 1: Matter
    "0_0": [
      Question(questionText: "Which consists of only one type of atom?", options: ["Molecule", "Element", "Compound", "Mixture"], correctIndex: 1),
      Question(questionText: "Carbon-12 and Carbon-14 are:", options: ["Isotopes", "Isomers", "Isobars", "Allotropes"], correctIndex: 0),
      Question(questionText: "Mr of water (H2O)? (H=1, O=16)", options: ["16", "17", "18", "20"], correctIndex: 2),
      Question(questionText: "Moles in 12.044 x 10^23 atoms of He?", options: ["1.0", "2.0", "0.5", "10.0"], correctIndex: 1),
      Question(questionText: "Simplest ratio of atoms formula?", options: ["Molecular", "Structural", "Empirical", "Displayed"], correctIndex: 2),
      Question(questionText: "Molarity of 2 mol NaCl in 0.5L?", options: ["1 M", "2 M", "4 M", "0.5 M"], correctIndex: 2),
      Question(questionText: "Not a physical property?", options: ["Melting point", "Density", "Flammability", "Boiling point"], correctIndex: 2),
      Question(questionText: "Avogadro Constant value?", options: ["6.02x10^22", "6.02x10^23", "9.81", "3.142"], correctIndex: 1),
      Question(questionText: "Charge of a proton?", options: ["Neutral", "Negative", "Positive", "Variable"], correctIndex: 2),
      Question(questionText: "Standard unit for amount of substance?", options: ["Gram", "Liter", "Mole", "Newton"], correctIndex: 2),
    ],

    // Chap 2: Atomic Structure
    "0_1": [
      Question(questionText: "Max electrons in s-orbital?", options: ["2", "6", "10", "14"], correctIndex: 0),
      Question(questionText: "Principal quantum number symbol?", options: ["n", "l", "m", "s"], correctIndex: 0),
      Question(questionText: "Shape of p-orbital?", options: ["Spherical", "Dumbbell", "Clover", "Complex"], correctIndex: 1),
      Question(questionText: "Electronic config of Na (Z=11)?", options: ["1s2 2s2 2p6 3s1", "1s2 2s2 2p5 3s2", "1s2 2s2 2p6", "1s2 2s2 2p6 3s2"], correctIndex: 0),
      Question(questionText: "Electrons fill lowest energy first?", options: ["Hund's Rule", "Pauli Principle", "Aufbau Principle", "Bohr's Model"], correctIndex: 2),
      Question(questionText: "Line spectrum of Hydrogen supports:", options: ["Wave nature", "Quantized energy", "Continuous energy", "Particle nature"], correctIndex: 1),
      Question(questionText: "Max electrons in n=3 shell?", options: ["8", "18", "32", "2"], correctIndex: 1),
      Question(questionText: "Quantum number 'l' for d-orbital?", options: ["0", "1", "2", "3"], correctIndex: 2),
      Question(questionText: "Two electrons in same orbital must have:", options: ["Same spin", "Opposite spin", "Same energy", "Different mass"], correctIndex: 1),
      Question(questionText: "Region with highest probability of finding electron?", options: ["Nucleus", "Orbit", "Orbital", "Node"], correctIndex: 2),
    ],

    // Chap 3: Periodic Table
    "0_2": [
      Question(questionText: "Vertical columns are called:", options: ["Periods", "Groups", "Blocks", "Series"], correctIndex: 1),
      Question(questionText: "Elements in Group 17 are:", options: ["Alkali Metals", "Noble Gases", "Halogens", "Transition Metals"], correctIndex: 2),
      Question(questionText: "Which has the largest atomic radius?", options: ["Li", "Na", "K", "Rb"], correctIndex: 3),
      Question(questionText: "Trend of electronegativity across a period?", options: ["Increases", "Decreases", "Constant", "Fluctuates"], correctIndex: 0),
      Question(questionText: "Block for Transition Metals?", options: ["s-block", "p-block", "d-block", "f-block"], correctIndex: 2),
      Question(questionText: "Element with highest ionization energy?", options: ["He", "Fr", "F", "H"], correctIndex: 0),
      Question(questionText: "Oxides of metals are generally:", options: ["Acidic", "Basic", "Neutral", "Amphoteric"], correctIndex: 1),
      Question(questionText: "Group 1 elements react with water to form:", options: ["Acids", "Alkalis", "Salts", "Gases"], correctIndex: 1),
      Question(questionText: "Effective nuclear charge across a period:", options: ["Increases", "Decreases", "Stays same", "Zero"], correctIndex: 0),
      Question(questionText: "Which is a metalloid?", options: ["Al", "Si", "C", "P"], correctIndex: 1),
    ],

    // Chap 4: Chemical Bonding
    "0_3": [
      Question(questionText: "Bond formed by transfer of electrons?", options: ["Covalent", "Ionic", "Metallic", "Hydrogen"], correctIndex: 1),
      Question(questionText: "Shape of CH4 molecule?", options: ["Linear", "Trigonal Planar", "Tetrahedral", "Bent"], correctIndex: 2),
      Question(questionText: "Bond angle in H2O?", options: ["180", "120", "109.5", "104.5"], correctIndex: 3),
      Question(questionText: "Type of bond in N2?", options: ["Single", "Double", "Triple", "Ionic"], correctIndex: 2),
      Question(questionText: "Intermolecular force in noble gases?", options: ["H-bond", "Dipole-Dipole", "London Dispersion", "Ionic"], correctIndex: 2),
      Question(questionText: "Which molecule has a dipole moment?", options: ["CO2", "CCl4", "NH3", "CH4"], correctIndex: 2),
      Question(questionText: "Hybridization of C in Ethene?", options: ["sp", "sp2", "sp3", "dsp2"], correctIndex: 1),
      Question(questionText: "Bond angle in BF3?", options: ["90", "109.5", "120", "180"], correctIndex: 2),
      Question(questionText: "Example of Hydrogen Bonding?", options: ["H2", "HCl", "HF", "CH4"], correctIndex: 2),
      Question(questionText: "Metallic bonding involves:", options: ["Shared pairs", "Sea of electrons", "Transfer", "Dipoles"], correctIndex: 1),
    ],

    // Chap 5: States of Matter
    "0_4": [
      Question(questionText: "Boyle's Law relates:", options: ["P and V", "V and T", "P and T", "V and n"], correctIndex: 0),
      Question(questionText: "Value of R in PV=nRT (L atm / mol K)?", options: ["8.314", "0.0821", "9.81", "1.01"], correctIndex: 1),
      Question(questionText: "Condition for ideal gas behavior?", options: ["High P, Low T", "Low P, High T", "High P, High T", "Low P, Low T"], correctIndex: 1),
      Question(questionText: "Process solid to gas directly?", options: ["Melting", "Freezing", "Sublimation", "Deposition"], correctIndex: 2),
      Question(questionText: "Viscosity is resistance to:", options: ["Compression", "Flow", "Heat", "Expansion"], correctIndex: 1),
      Question(questionText: "Boiling point is when vapor pressure equals:", options: ["1 atm", "Atmospheric P", "Critical P", "Zero"], correctIndex: 1),
      Question(questionText: "Charles's Law involves constant:", options: ["Pressure", "Volume", "Temperature", "Moles"], correctIndex: 0),
      Question(questionText: "Crystalline solids have:", options: ["Random arrangement", "Ordered arrangement", "No shape", "Fluidity"], correctIndex: 1),
      Question(questionText: "Unit cell with atoms at corners & center?", options: ["SCC", "FCC", "BCC", "HCP"], correctIndex: 2),
      Question(questionText: "Triple point is where:", options: ["Solid melts", "Liquid boils", "3 phases coexist", "Gas ideal"], correctIndex: 2),
    ],

    // Chap 6: Chemical Equilibrium
    "0_5": [
      Question(questionText: "If K > 1, equilibrium favors:", options: ["Reactants", "Products", "Neither", "Both"], correctIndex: 1),
      Question(questionText: "Le Chatelier: Increase P favors side with:", options: ["More gas moles", "Fewer gas moles", "Exothermic", "Endothermic"], correctIndex: 1),
      Question(questionText: "Catalyst effect on K?", options: ["Increase", "Decrease", "No Change", "Zero"], correctIndex: 2),
      Question(questionText: "Expression for Kc depends on:", options: ["Solids", "Liquids", "Gases/Aqueous", "Catalysts"], correctIndex: 2),
      Question(questionText: "Kp = Kc(RT)^dn. dn is:", options: ["Moles reactants", "Moles products", "Prod - React (gas)", "React - Prod"], correctIndex: 2),
      Question(questionText: "Q < K means reaction proceeds:", options: ["Forward", "Backward", "At Equilibrium", "Stops"], correctIndex: 0),
      Question(questionText: "Heterogeneous equilibrium involves:", options: ["One phase", "Multiple phases", "Only gases", "Only liquids"], correctIndex: 1),
      Question(questionText: "Unit of K depends on:", options: ["Temperature", "Stoichiometry", "Pressure", "Catalyst"], correctIndex: 1),
      Question(questionText: "Adding inert gas at constant V?", options: ["Shifts Left", "Shifts Right", "No Change", "Stops"], correctIndex: 2),
      Question(questionText: "Endothermic reaction, increase T?", options: ["K increases", "K decreases", "K constant", "Reaction stops"], correctIndex: 0),
    ],


    // ===================================================
    // SEMESTER 2 (7 Chapters)
    // ===================================================

    // Chap 1: Reaction Kinetics
    "1_0": [
      Question(questionText: "Order if rate is independent of conc?", options: ["Zero", "First", "Second", "Third"], correctIndex: 0),
      Question(questionText: "Unit of k for first order?", options: ["M/s", "1/s", "1/M s", "M"], correctIndex: 1),
      Question(questionText: "Energy required to start reaction?", options: ["Enthalpy", "Gibbs Energy", "Activation Energy", "Kinetic Energy"], correctIndex: 2),
      Question(questionText: "Slope of Arrhenius plot (ln k vs 1/T)?", options: ["-Ea/R", "Ea/R", "-k", "A"], correctIndex: 0),
      Question(questionText: "Substance increasing rate without being consumed?", options: ["Reactant", "Product", "Catalyst", "Intermediate"], correctIndex: 2),
      Question(questionText: "Half-life of first order reaction depends on?", options: ["Concentration", "k only", "Temperature", "Pressure"], correctIndex: 1),
      Question(questionText: "Molecularity is:", options: ["Order of rxn", "Colliding species", "Rate constant", "Half life"], correctIndex: 1),
      Question(questionText: "Rate determining step is the:", options: ["Fastest step", "Slowest step", "Last step", "First step"], correctIndex: 1),
      Question(questionText: "Collision theory requires:", options: ["Correct orientation", "Enough energy", "Both A & B", "None"], correctIndex: 2),
      Question(questionText: "Catalyst works by:", options: ["Increasing T", "Lowering Ea", "Increasing Conc", "Changing K"], correctIndex: 1),
    ],

    // Chap 2: Thermochemistry
    "1_1": [
      Question(questionText: "Exothermic reaction, delta H is:", options: ["Positive", "Negative", "Zero", "Undefined"], correctIndex: 1),
      Question(questionText: "Standard conditions temperature?", options: ["0 C", "25 C", "100 C", "273 K"], correctIndex: 1),
      Question(questionText: "Hess's Law relates to:", options: ["Rates", "Equilibrium", "Enthalpy Change", "Entropy"], correctIndex: 2),
      Question(questionText: "Entropy (S) measures:", options: ["Heat", "Disorder", "Energy", "Speed"], correctIndex: 1),
      Question(questionText: "Spontaneous if delta G is:", options: ["Positive", "Negative", "Zero", "Large"], correctIndex: 1),
      Question(questionText: "Enthalpy of formation for elements?", options: ["100 kJ", "0 kJ", "Negative", "Positive"], correctIndex: 1),
      Question(questionText: "Breaking bonds is:", options: ["Exothermic", "Endothermic", "Neutral", "Spontaneous"], correctIndex: 1),
      Question(questionText: "Bomb calorimeter measures:", options: ["Delta H", "Delta E", "Delta G", "Delta S"], correctIndex: 1),
      Question(questionText: "Specific heat capacity unit?", options: ["J", "J/g K", "kJ/mol", "K"], correctIndex: 1),
      Question(questionText: "Reaction is feasible when:", options: ["Delta G < 0", "Delta H > 0", "Delta S < 0", "K < 1"], correctIndex: 0),
    ],

    // Chap 3: Electrochemistry
    "1_2": [
      Question(questionText: "Oxidation occurs at:", options: ["Anode", "Cathode", "Bridge", "Wire"], correctIndex: 0),
      Question(questionText: "Electrons flow from:", options: ["Anode to Cathode", "Cathode to Anode", "Solution to Wire", "Salt Bridge"], correctIndex: 0),
      Question(questionText: "Standard Hydrogen Electrode potential?", options: ["1.0 V", "0.0 V", "-1.0 V", "0.5 V"], correctIndex: 1),
      Question(questionText: "Nernst Equation calculates:", options: ["Standard E", "Non-standard E", "K", "Delta G"], correctIndex: 1),
      Question(questionText: "Faraday's Constant value?", options: ["96500", "8.314", "6.02x10^23", "1.6x10^-19"], correctIndex: 0),
      Question(questionText: "Salt bridge function?", options: ["Electron flow", "Maintain neutrality", "Provide energy", "Mix solutions"], correctIndex: 1),
      Question(questionText: "Positive E_cell means:", options: ["Spontaneous", "Non-spontaneous", "Equilibrium", "Impossible"], correctIndex: 0),
      Question(questionText: "In electrolysis of NaCl(aq), cathode product?", options: ["Na", "H2", "Cl2", "O2"], correctIndex: 1),
      Question(questionText: "Unit of Charge?", options: ["Volt", "Ampere", "Coulomb", "Farad"], correctIndex: 2),
      Question(questionText: "Cell notation: Anode is on the:", options: ["Left", "Right", "Middle", "Bottom"], correctIndex: 0),
    ],

    // Chap 4: Intro Organic Chem
    "1_3": [
      Question(questionText: "Functional group of Alcohols?", options: ["-COOH", "-OH", "-NH2", "-CHO"], correctIndex: 1),
      Question(questionText: "General formula of Alkanes?", options: ["CnH2n+2", "CnH2n", "CnH2n-2", "CnH2n+1OH"], correctIndex: 0),
      Question(questionText: "Same connectivity, different arrangement?", options: ["Structural", "Stereoisomers", "Chain", "Functional"], correctIndex: 1),
      Question(questionText: "Hybridization of C in Ethene?", options: ["sp3", "sp2", "sp", "dsp3"], correctIndex: 1),
      Question(questionText: "Reaction: C2H4 + H2 -> C2H6?", options: ["Substitution", "Elimination", "Addition", "Hydrolysis"], correctIndex: 2),
      Question(questionText: "Isomerism in But-2-ene?", options: ["Optical", "Cis-Trans", "Chain", "Position"], correctIndex: 1),
      Question(questionText: "Free radical initiation requires:", options: ["Heat", "UV Light", "Catalyst", "Acid"], correctIndex: 1),
      Question(questionText: "Electrophile is:", options: ["Electron rich", "Electron poor", "Neutral", "Negative"], correctIndex: 1),
      Question(questionText: "Nucleophile example?", options: ["H+", "Br+", "NH3", "AlCl3"], correctIndex: 2),
      Question(questionText: "Homolytic fission produces:", options: ["Ions", "Radicals", "Molecules", "Atoms"], correctIndex: 1),
    ],

    // Chap 5: Hydrocarbons
    "1_4": [
      Question(questionText: "Alkane halogenation mechanism?", options: ["Electrophilic Add", "Nucleophilic Sub", "Free Radical Sub", "Elimination"], correctIndex: 2),
      Question(questionText: "Test for Alkenes?", options: ["Lime Water", "Bromine Water", "Litmus", "Splint"], correctIndex: 1),
      Question(questionText: "Markovnikov's rule applies to:", options: ["Alkanes", "Alkenes Addition", "Benzene", "Alcohols"], correctIndex: 1),
      Question(questionText: "Benzene undergoes mainly:", options: ["Electrophilic Sub", "Nucleophilic Add", "Elimination", "Free Radical"], correctIndex: 0),
      Question(questionText: "Shape of Benzene?", options: ["Chair", "Planar Hexagon", "Boat", "Tetrahedral"], correctIndex: 1),
      Question(questionText: "Major product of Propene + HBr?", options: ["1-bromopropane", "2-bromopropane", "Propane", "Propyne"], correctIndex: 1),
      Question(questionText: "Combustion of Alkane gives:", options: ["CO2 + H2", "CO2 + H2O", "CO + C", "H2O only"], correctIndex: 1),
      Question(questionText: "Toluene is:", options: ["Methylbenzene", "Ethylbenzene", "Phenol", "Aniline"], correctIndex: 0),
      Question(questionText: "Nitrobenzene formation reagent?", options: ["HNO3", "H2SO4", "HNO3 + H2SO4", "HCl"], correctIndex: 2),
      Question(questionText: "Alkyne general formula?", options: ["CnH2n", "CnH2n-2", "CnH2n+2", "CnHn"], correctIndex: 1),
    ],

    // Chap 6: Haloalkanes
    "1_5": [
      Question(questionText: "SN1 favored by:", options: ["Primary", "Secondary", "Tertiary", "Methyl"], correctIndex: 2),
      Question(questionText: "Best leaving group?", options: ["F-", "Cl-", "Br-", "I-"], correctIndex: 3),
      Question(questionText: "SN2 steps?", options: ["One", "Two", "Three", "Zero"], correctIndex: 0),
      Question(questionText: "Haloalkane + NaOH(aq)?", options: ["Alkene", "Alcohol", "Ether", "Alkane"], correctIndex: 1),
      Question(questionText: "Haloalkane + Mg in dry ether?", options: ["Grignard", "Gilman", "Carbene", "Salt"], correctIndex: 0),
      Question(questionText: "Haloalkane + Ethanolic KOH?", options: ["Substitution", "Elimination", "Addition", "Oxidation"], correctIndex: 1),
      Question(questionText: "Order of reactivity (C-X bond)?", options: ["C-F > C-I", "C-I > C-Br > C-Cl", "C-Cl > C-I", "Equal"], correctIndex: 1),
      Question(questionText: "SN2 kinetics?", options: ["Rate = k[RX]", "Rate = k[Nu]", "Rate = k[RX][Nu]", "Zero order"], correctIndex: 2),
      Question(questionText: "Inversion of config occurs in:", options: ["SN1", "SN2", "E1", "E2"], correctIndex: 1),
      Question(questionText: "Racemization occurs in:", options: ["SN1", "SN2", "E2", "Addition"], correctIndex: 0),
    ],

    // Chap 7: Hydroxy Compounds
    "1_6": [
      Question(questionText: "Lucas Reagent tests for:", options: ["Alkenes", "Acids", "Alcohols", "Amines"], correctIndex: 2),
      Question(questionText: "Oxidation of Primary Alcohol?", options: ["Ketone", "Aldehyde/Acid", "Alkene", "Ether"], correctIndex: 1),
      Question(questionText: "Phenol vs Ethanol acidity?", options: ["Phenol > Ethanol", "Ethanol > Phenol", "Equal", "Neutral"], correctIndex: 0),
      Question(questionText: "Dehydration of Ethanol gives:", options: ["Ethane", "Ethene", "Ethyne", "Ethanal"], correctIndex: 1),
      Question(questionText: "Phenol + Bromine water?", options: ["No reaction", "White ppt", "Red gas", "Blue soln"], correctIndex: 1),
      Question(questionText: "Secondary alcohol oxidizes to:", options: ["Aldehyde", "Ketone", "Acid", "No reaction"], correctIndex: 1),
      Question(questionText: "Alcohol + Na metal gives:", options: ["H2 gas", "O2 gas", "CO2", "H2O"], correctIndex: 0),
      Question(questionText: "Product of Phenol + NaOH?", options: ["Sodium Phenoxide", "Benzene", "Cyclohexanol", "No reaction"], correctIndex: 0),
      Question(questionText: "Esterification: Alcohol + ?", options: ["Base", "Carboxylic Acid", "Ketone", "Ether"], correctIndex: 1),
      Question(questionText: "Iodoform test identifies:", options: ["Methyl Ketones/Alcohols", "Acids", "Amines", "Esters"], correctIndex: 0),
    ],
  };

  // --- GETTER ---
  static List<Question> getQuestions(int semIndex, int chapterIndex) {
    String key = "${semIndex}_$chapterIndex";
    // Initialize if empty to avoid crashes, but logic above covers all 13 chapters.
    if (!_database.containsKey(key)) {
      _database[key] = [];
    }
    return _database[key]!;
  }

  // --- LECTURER TOOLS ---
  static void addQuestion(int semIndex, int chapterIndex, Question q) {
    getQuestions(semIndex, chapterIndex).add(q);
  }

  static void deleteQuestion(int semIndex, int chapterIndex, int questionIndex) {
    getQuestions(semIndex, chapterIndex).removeAt(questionIndex);
  }

  static void editQuestion(int semIndex, int chapterIndex, int questionIndex, Question newQ) {
    getQuestions(semIndex, chapterIndex)[questionIndex] = newQ;
  }
}