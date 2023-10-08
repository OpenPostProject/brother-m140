/**
  Copyright (C) 2012-2023 by Autodesk, Inc.
  All rights reserved.

  Brother Speedio post processor configuration.

  $Revision: 44083 1c5ad993a086f043365c6f9038d5d6561bad0ddd $
  $Date: 2023-08-12 05:06:32 $

  FORKID {C09133CD-6F13-4DFC-9EB8-41260FBB5B08}
*/

///////////////////////////////////////////////////////////////////////////////
//                        MANUAL NC COMMANDS
//
// The following ACTION commands are supported by this post.
//
//     turningAngle:angle         - Defines the XY rotation angle for turning
//
///////////////////////////////////////////////////////////////////////////////

description = "Brother Speedio M140X2";
vendor = "Brother";
vendorUrl = "http://www.brother.com";
legal = "Copyright (C) 2012-2023 by Autodesk, Inc.";
certificationLevel = 2;
minimumRevision = 45702;

longDescription = "Generic milling post for Brother Speedio M140X2 with support for mill-turn.  Use turret 2 to turn in the Y-axis with the A-axis at 90 degrees.";

extension = "NC";
programNameIsInteger = false;
setCodePage("ascii");

capabilities = CAPABILITY_MILLING | CAPABILITY_TURNING;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.25, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(180);
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion
highFeedrate = (unit == IN) ? 500 : 5000;

// user-defined properties
properties = {
  writeMachine: {
    title      : "Write machine",
    description: "Output the machine settings in the header of the code.",
    group      : "formats",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  writeTools: {
    title      : "Write tool list",
    description: "Output a tool list in the header of the code.",
    group      : "formats",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  preloadTool: {
    title      : "Preload tool",
    description: "Preloads the next tool at a tool change (if any).",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  showSequenceNumbers: {
    title      : "Use sequence numbers",
    description: "'Yes' outputs sequence numbers on each block, 'Only on tool change' outputs sequence numbers on tool change blocks only, and 'No' disables the output of sequence numbers.",
    group      : "formats",
    type       : "enum",
    values     : [
      {title:"Yes", id:"true"},
      {title:"No", id:"false"},
      {title:"Only on tool change", id:"toolChange"}
    ],
    value: "toolChange",
    scope: "post"
  },
  sequenceNumberStart: {
    title      : "Start sequence number",
    description: "The number at which to start the sequence numbers.",
    group      : "formats",
    type       : "integer",
    value      : 10,
    scope      : "post"
  },
  sequenceNumberIncrement: {
    title      : "Sequence number increment",
    description: "The amount by which the sequence number is incremented by in each block.",
    group      : "formats",
    type       : "integer",
    value      : 5,
    scope      : "post"
  },
  optionalStop: {
    title      : "Optional stop",
    description: "Outputs optional stop code during when necessary in the code.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  separateWordsWithSpace: {
    title      : "Separate words with space",
    description: "Adds spaces between words if 'yes' is selected.",
    group      : "formats",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  useRadius: {
    title      : "Radius arcs",
    description: "If yes is selected, arcs are outputted using radius values rather than IJK.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  useParametricFeed: {
    title      : "Parametric feed",
    description: "Specifies the feed value that should be output using a Q value.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  showNotes: {
    title      : "Show notes",
    description: "Writes operation notes as comments in the outputted code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  probingType: {
    title      : "Probing type",
    description: "Specified what probing cycles are used on the machine.",
    group      : "probing",
    type       : "enum",
    values     : [
      {title:"Renishaw", id:"Renishaw"},
      {title:"Blum", id:"Blum"}
    ],
    value: "Renishaw",
    scope: "post"
  },
  useSimpleThread: {
    title      : "Use simple threading cycle",
    description: "Enable to output G392 simple threading cycle, disable to output G376 standard threading cycle.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  washdownCoolant: {
    title      : "Washdown coolant",
    description: "Specifies whether washdown coolant should be used and where it is output.",
    group      : "preferences",
    type       : "enum",
    values     : [
      {title:"Off", id:"off"},
      {title:"Always on", id:"always"},
      {title:"End of operation", id:"operationEnd"},
      {title:"Program end", id:"programEnd"}
    ],
    value: "off",
    scope: "post"
  },
  usePitchForTapping: {
    title      : "Use Pitch/TPI for tapping",
    description: "Enables the use of pitch and threads per inch instead of feed for tapping cycles. Using G77/78 instead of G84/74.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  doubleTapWithdrawSpeed: {
    title      : "Double the tap withdraw speed",
    description: "If enabled, an L value containing double the spindle speed (up to 6000) will be output in the G77 tapping cycle.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  smoothingMode: {
    title      : "High accuracy mode",
    description: "Select the high accuracy mode supported by the control.",
    group      : "preferences",
    type       : "enum",
    values     : [
      {title:"A", id:"A"},
      {title:"B", id:"B"},
      {title:"M298", id:"M298"}
    ],
    value: "A"
  },
  useSmoothing: {
    title      : "High accuracy level",
    description: "Select the high accuracy level to use for machining.",
    group      : "preferences",
    type       : "enum",
    values     : [
      {title:"Off", id:"-1"},
      {title:"Automatic", id:"9999"},
      {title:"Standard", id:"0"}, // 0
      {title:"Roughing", id:"1"}, // 5
      {title:"Medium rough", id:"2"}, // 3
      {title:"Medium rough high", id:"3"}, // 4
      {title:"Finishing", id:"4"}, // 1
      {title:"Finishing high", id:"5"} // 2
    ],
    value: "-1"
  },
  useTurning: {
    title      : "Turning mode is supported",
    description: "Used the enable/disable the turning capabilities of the machine.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  turningAngle: {
    title      : "XY-rotation for turning",
    description: "Select the XY angle for turning.  0 = Along X, 90 = Along Y, 180 = Along -X, etc.",
    group      : "preferences",
    type       : "angle",
    value      : 0,
    scope      : "post"
  },
  useInverseTime: {
    title      : "Use inverse time feedrates",
    description: "'Yes' enables inverse time feedrates, 'No' outputs DPM feedrates.",
    group      : "multiAxis",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  xHomePosition: {
    title      : "X-axis home position",
    description: "Define the X home position to move to at end of program.",
    group      : "homePositions",
    type       : "spatial",
    value      : 0,
    scope      : "post"
  },
  safePositionMethod: {
    title      : "Safe Retracts",
    description: "Select your desired retract option. 'Clearance Height' retracts to the operation clearance height.",
    group      : "homePositions",
    type       : "enum",
    values     : [
      // {title:"G28", id: "G28"},
      {title:"G53", id:"G53"},
      {title:"Clearance Height", id:"clearanceHeight"}
    ],
    value: "G53",
    scope: "post"
  },
  singleResultsFile: {
    title      : "Create single results file",
    description: "Set to false if you want to store the measurement results for each probe / inspection toolpath in a separate file",
    group      : "probing",
    type       : "boolean",
    value      : true,
    scope      : "post"
  }
};

// wcs definiton
wcsDefinitions = {
  useZeroOffset: false,
  wcs          : [
    {name:"Standard", format:"G", range:[54, 59]},
    {name:"Extended", format:"G54.1 P", range:[1, 300]}
  ]
};

var singleLineCoolant = false; // specifies to output multiple coolant codes in one line rather than in separate lines
// samples:
// {id: COOLANT_THROUGH_TOOL, on: 88, off: 89}
// {id: COOLANT_THROUGH_TOOL, on: [8, 88], off: [9, 89]}
// {id: COOLANT_THROUGH_TOOL, on: "M88 P3 (myComment)", off: "M89"}
var coolants = [
  {id:COOLANT_FLOOD, on:8},
  {id:COOLANT_MIST},
  {id:COOLANT_THROUGH_TOOL, on:494, off:495},
  {id:COOLANT_AIR},
  {id:COOLANT_AIR_THROUGH_TOOL},
  {id:COOLANT_SUCTION},
  {id:COOLANT_FLOOD_MIST},
  {id:COOLANT_FLOOD_THROUGH_TOOL, on:[8, 494], off:[9, 495]},
  {id:COOLANT_OFF, off:9}
];
var washdownCoolant = {on:400, off:401};

var permittedCommentChars = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,=_-";

var gFormat = createFormat({prefix:"G", width:2, zeropad:true, decimals:1});
var mFormat = createFormat({prefix:"M", width:2, zeropad:true, decimals:1});
var hFormat = createFormat({prefix:"H", width:2, zeropad:true, decimals:1});
var dFormat = createFormat({prefix:"D", width:2, zeropad:true, decimals:1});
var pFormat = createFormat({prefix:"P", decimals:1});
var integerFormat = createFormat({decimals:0});
var probeWCSFormat = createFormat({decimals:0, forceDecimal:true});

var xyzFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:false});
var xFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:false});
var yFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:false});
var rFormat = xyzFormat; // radius
var abcFormat = createFormat({decimals:3, forceDecimal:true, scale:DEG});
var feedFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:false});
var pitchFormat = createFormat({decimals:4, forceDecimal:false});
var threadPQFormat = createFormat({decimals:0, forceDecimal:false, trim:true, scale:(unit == MM ? 1000 : 10000)});
var toolFormat = createFormat({width:2, zeropad:true, decimals:1});
var rpmFormat = createFormat({decimals:0});
var secFormat = createFormat({decimals:3, forceDecimal:true}); // seconds - range 0.001-99999.999
var taperFormat = createFormat({decimals:1, scale:DEG});

var xOutput = createVariable({prefix:"X"}, xFormat);
var yOutput = createVariable({prefix:"Y"}, yFormat);
var zOutput = createVariable({onchange:function() {retracted = false;}, prefix:"Z"}, xyzFormat);
var aOutput = createVariable({prefix:"A"}, abcFormat);
var bOutput = createVariable({prefix:"B"}, abcFormat);
var cOutput = createVariable({prefix:"C"}, abcFormat);
var feedOutput = createVariable({prefix:"F"}, feedFormat);
var pitchOutput = createVariable({prefix:"F"}, pitchFormat);
var cyclefeedOutput = createVariable({prefix:"F", force:true}, feedFormat);
var sOutput = createVariable({prefix:"S", force:true}, rpmFormat);
var qOutput = createVariable({prefix:"Q", force:true}, rpmFormat);
var dOutput = createVariable({}, dFormat);
var pOutput = createVariable({force:true}, pFormat);
var threadROutput = createVariable({prefix:"R", force:true}, threadPQFormat);
var g92ROutput = createVariable({prefix:"R", force:true}, xyzFormat);
var g92QOutput = createVariable({prefix:"Q", force:true}, xyzFormat);

// circular output
var iOutput = createReferenceVariable({prefix:"I"}, xyzFormat);
var jOutput = createReferenceVariable({prefix:"J"}, xyzFormat);
var kOutput = createReferenceVariable({prefix:"K"}, xyzFormat);

var gMotionModal = createModal({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createModal({onchange:function () {gMotionModal.reset();}}, gFormat); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat); // modal group 3 // G90-91
var gFeedModeModal = createModal({}, gFormat); // modal group 5 // G94-95
var gSpindleModeModal = createModal({}, gFormat); // modal group 5 // G96-97
var gUnitModal = createModal({}, gFormat); // modal group 6 // G20-21
var gCycleModal = createModal({force:true}, gFormat); // modal group 9 // G81, ...
var gRetractModal = createModal({}, gFormat); // modal group 10 // G98-99
var gInfeedModal = createModal({}, gFormat); // G321-G323
var mTurningModal = createModal({}, mFormat);
var gRotationModal = createModal({
  onchange: function () {
    if (probeVariables.probeAngleMethod == "G68") {
      probeVariables.outputRotationCodes = true;
    }
  }
}, gFormat); // modal group 16 // G68-G69

// fixed settings
var firstFeedParameter = 500;
var useMultiAxisFeatures = false;
var forceMultiAxisIndexing = false; // force multi-axis indexing for 3D programs
var cancelTiltFirst = true; // cancel G68.2 with G69 prior to G54-G59 WCS block
var useABCPrepositioning = false; // position ABC axes prior to G68.2 block
var maximumSpindleSpeed = 16000; // could be 10000
var maximumTurningSpeed = 2000; // maximum turning speed for C-axis

var allowIndexingWCSProbing = false; // specifies that probe WCS with tool orientation is supported
var probeVariables = {
  outputRotationCodes: false, // defines if it is required to output rotation codes
  probeAngleMethod   : "OFF", // OFF, AXIS_ROT, G68, G54.4
  compensationXY     : undefined
};

// collected state
var sequenceNumber;
var forceSpindleSpeed = false;
var currentWorkOffset;
var optionalSection = false;
var activeMovements; // do not use by default
var currentFeedId;
var retracted = false; // specifies that the tool has been retracted to the safe plane
var isTurningOperation;
var currentFeedMode;
var turningYAxis = false;
var reverseCC = false;
var saveTurningAngle;
var sfmAxis;
var showSequenceNumbers;
probeMultipleFeatures = true;

/**
  Writes the specified block.
*/
function writeBlock() {
  var text = formatWords(arguments);
  if (!text) {
    return;
  }
  if (showSequenceNumbers == "true") {
    if (optionalSection) {
      if (text) {
        writeWords("/", "N" + sequenceNumber, text);
      }
    } else {
      writeWords2("N" + sequenceNumber, arguments);
    }
    sequenceNumber += getProperty("sequenceNumberIncrement");
  } else {
    if (optionalSection) {
      if (text) {
        writeWords("/", text);
      }
    } else {
      writeWords(arguments);
    }
  }
}

/**
  Writes the specified optional block.
*/
function writeOptionalBlock() {
  if (showSequenceNumbers == "true") {
    var words = formatWords(arguments);
    if (words) {
      writeWords("/", "N" + sequenceNumber, words);
      sequenceNumber += getProperty("sequenceNumberIncrement");
    }
  } else {
    writeWords("/", arguments);
  }
}

function formatComment(text) {
  return "(" + filterText(String(text).toUpperCase(), permittedCommentChars).replace(/[()]/g, "") + ")";
}

/**
  Output a comment.
*/
function writeComment(text) {
  writeln(formatComment(text));
}

function onOpen() {
  turningAngle = getProperty("turningAngle") * -1; // turning rotation is in opposite direction of C-axis rotation
  turningAngle = turningAngle < 0 ? turningAngle + 360 : turningAngle;
  if (turningAngle < 0 || turningAngle > 360) {
    error(localize("TurningAngle must be between 0 and 360 degrees."));
  }
  saveTurningAngle = turningAngle;

  if (getProperty("useRadius")) {
    maximumCircularSweep = toRad(90); // avoid potential center calculation errors for CNC
  }
  gRotationModal.format(69); // Default to G69 Rotation Off

  showSequenceNumbers = getProperty("showSequenceNumbers");

  if (true) { // note: setup your machine here
    var aAxis = createAxis({coordinate:0, table:true, axis:[1, 0, 0], range:[-30, 120], preference:1});
    var cAxis = createAxis({coordinate:2, table:true, axis:[0, 0, 1]});
    machineConfiguration = new MachineConfiguration(aAxis, cAxis);

    setMachineConfiguration(machineConfiguration);
    optimizeMachineAngles2(1); // TCP mode disabled
  }

  if (!machineConfiguration.isMachineCoordinate(0)) {
    aOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(1)) {
    bOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(2)) {
    cOutput.disable();
  }

  if (!getProperty("separateWordsWithSpace")) {
    setWordSeparator("");
  }

  sequenceNumber = getProperty("sequenceNumberStart");

  if (programName) {
    if (programComment) {
      writeComment(programName + " (" + filterText(String(programComment).toUpperCase(), permittedCommentChars) + ")");
    } else {
      writeComment(programName);
    }
  } else {
    error(localize("Program name has not been specified."));
    return;
  }

  // dump machine configuration
  var vendor = machineConfiguration.getVendor();
  var model = machineConfiguration.getModel();
  var description = machineConfiguration.getDescription();

  if (getProperty("writeMachine") && (vendor || model || description)) {
    writeComment(localize("Machine"));
    if (vendor) {
      writeComment("  " + localize("vendor") + ": " + vendor);
    }
    if (model) {
      writeComment("  " + localize("model") + ": " + model);
    }
    if (description) {
      writeComment("  " + localize("description") + ": "  + description);
    }
  }

  // dump tool information
  if (getProperty("writeTools")) {
    var zRanges = {};
    if (is3D()) {
      var numberOfSections = getNumberOfSections();
      for (var i = 0; i < numberOfSections; ++i) {
        var section = getSection(i);
        var zRange = section.getGlobalZRange();
        var tool = section.getTool();
        if (zRanges[tool.number]) {
          zRanges[tool.number].expandToRange(zRange);
        } else {
          zRanges[tool.number] = zRange;
        }
      }
    }

    var tools = getToolTable();
    if (tools.getNumberOfTools() > 0) {
      for (var i = 0; i < tools.getNumberOfTools(); ++i) {
        var tool = tools.getTool(i);
        var comment = "T" + toolFormat.format(tool.number) + " " +
          (tool.diameter != 0 ? "D=" + xyzFormat.format(tool.diameter) + " " : "") +
          (tool.isTurningTool() ? localize("NR") + "=" + xyzFormat.format(tool.noseRadius) : localize("CR") + "=" + xyzFormat.format(tool.cornerRadius)) +
          (tool.taperAngle > 0 && (tool.taperAngle < Math.PI) ? " " + localize("TAPER") + "=" + taperFormat.format(tool.taperAngle) + localize("deg") : "") +
          (zRanges[tool.number] ? " - " + localize("ZMIN") + "=" + xyzFormat.format(zRanges[tool.number].getMinimum()) : "") +
          " - " + localize(getToolTypeName(tool.type));
        writeComment(comment);
      }
    }
  }

  if (false) {
    // check for duplicate tool number
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var sectioni = getSection(i);
      var tooli = sectioni.getTool();
      for (var j = i + 1; j < getNumberOfSections(); ++j) {
        var sectionj = getSection(j);
        var toolj = sectionj.getTool();
        if (tooli.number == toolj.number) {
          if (xyzFormat.areDifferent(tooli.diameter, toolj.diameter) ||
              xyzFormat.areDifferent(tooli.cornerRadius, toolj.cornerRadius) ||
              abcFormat.areDifferent(tooli.taperAngle, toolj.taperAngle) ||
              (tooli.numberOfFlutes != toolj.numberOfFlutes)) {
            error(
              subst(
                localize("Using the same tool number for different cutter geometry for operation '%1' and '%2'."),
                sectioni.hasParameter("operation-comment") ? sectioni.getParameter("operation-comment") : ("#" + (i + 1)),
                sectionj.hasParameter("operation-comment") ? sectionj.getParameter("operation-comment") : ("#" + (j + 1))
              )
            );
            return;
          }
        }
      }
    }
  }

  if ((getNumberOfSections() > 0) && (getSection(0).workOffset == 0)) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      if (getSection(i).workOffset > 0) {
        error(localize("Using multiple work offsets is not possible if the initial work offset is 0."));
        return;
      }
    }
  }

  // absolute coordinates and feed per min
  writeBlock(gFormat.format(0), gAbsIncModal.format(90), gFormat.format(40), gFormat.format(80));
  writeBlock(gFeedModeModal.format(94), gFormat.format(49));

  writeComment("File output in " + (unit == 1 ? "MM" : "inches") + ". Please ensure the unit is set correctly on the control");
}

function onComment(message) {
  var comments = String(message).split(";");
  for (comment in comments) {
    writeComment(comments[comment]);
  }
}

/** Force output of X, Y, and Z. */
function forceXYZ() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

/** Force output of A, B, and C. */
function forceABC() {
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
}

function forceFeed() {
  currentFeedId = undefined;
  feedOutput.reset();
}

/** Force output of X, Y, Z, A, B, C, and F on next output. */
function forceAny() {
  forceXYZ();
  forceABC();
  forceFeed();
}

function forceModals() {
  if (arguments.length == 0) { // reset all modal variables listed below
    if (typeof gMotionModal != "undefined") {
      gMotionModal.reset();
    }
    if (typeof gPlaneModal != "undefined") {
      gPlaneModal.reset();
    }
    if (typeof gAbsIncModal != "undefined") {
      gAbsIncModal.reset();
    }
    if (typeof gFeedModeModal != "undefined") {
      gFeedModeModal.reset();
    }
  } else {
    for (var i in arguments) {
      arguments[i].reset(); // only reset the modal variable passed to this function
    }
  }
}

// Start of smoothing logic
var smoothingSettings = {
  roughing              : 2, // roughing level for smoothing in automatic mode
  semi                  : 3, // semi-roughing level for smoothing in automatic mode
  semifinishing         : 4, // semi-finishing level for smoothing in automatic mode
  finishing             : 5, // finishing level for smoothing in automatic mode
  thresholdRoughing     : toPreciseUnit(0.5, MM), // operations with stock/tolerance above that threshold will use roughing level in automatic mode
  thresholdFinishing    : toPreciseUnit(0.05, MM), // operations with stock/tolerance below that threshold will use finishing level in automatic mode
  thresholdSemiFinishing: toPreciseUnit(0.1, MM), // operations with stock/tolerance above finishing and below threshold roughing that threshold will use semi finishing level in automatic mode

  differenceCriteria: "level", // options: "level", "tolerance", "both". Specifies criteria when output smoothing codes
  autoLevelCriteria : "stock", // use "stock" or "tolerance" to determine levels in automatic mode
  cancelCompensation: false // tool length compensation must be canceled prior to changing the smoothing level
};

// collected state below, do not edit
var smoothing = {
  cancel     : false, // cancel tool length prior to update smoothing for this operation
  isActive   : false, // the current state of smoothing
  isAllowed  : false, // smoothing is allowed for this operation
  isDifferent: false, // tells if smoothing levels/tolerances/both are different between operations
  level      : -1, // the active level of smoothing
  tolerance  : -1, // the current operation tolerance
  force      : false // smoothing needs to be forced out in this operation
};

function initializeSmoothing() {
  var previousLevel = smoothing.level;
  var previousTolerance = smoothing.tolerance;

  // determine new smoothing levels and tolerances
  smoothing.level = parseInt(getProperty("useSmoothing"), 10);
  smoothing.level = isNaN(smoothing.level) ? -1 : smoothing.level;
  smoothing.tolerance = Math.max(getParameter("operation:tolerance", smoothingSettings.thresholdFinishing), 0);

  // setup for proper smoothing mode
  switch (getProperty("smoothingMode")) {
  case "A":
  case "B":
    smoothingSettings.roughing = 5;
    smoothingSettings.semi = 3;
    smoothingSettings.semifinishing = 1;
    smoothingSettings.finishing = 2;
    smoothing.level = (smoothing.level >= 0 && smoothing.level <= 5) ? [0, 5, 3, 4, 1, 2][smoothing.level] : smoothing.level;
    break;
  }
  // automatically determine smoothing level
  if (smoothing.level == 9999) {
    if (smoothingSettings.autoLevelCriteria == "stock") { // determine auto smoothing level based on stockToLeave
      var stockToLeave = xyzFormat.getResultingValue(getParameter("operation:stockToLeave", 0));
      var verticalStockToLeave = xyzFormat.getResultingValue(getParameter("operation:verticalStockToLeave", 0));
      if (((stockToLeave >= smoothingSettings.thresholdRoughing) && (verticalStockToLeave >= smoothingSettings.thresholdRoughing)) ||
          getParameter("operation:strategy", "") == "face") {
        smoothing.level = smoothingSettings.roughing; // set roughing level
      } else {
        if (((stockToLeave >= smoothingSettings.thresholdSemiFinishing) && (stockToLeave < smoothingSettings.thresholdRoughing)) &&
          ((verticalStockToLeave >= smoothingSettings.thresholdSemiFinishing) && (verticalStockToLeave  < smoothingSettings.thresholdRoughing))) {
          smoothing.level = smoothingSettings.semi; // set semi level
        } else if (((stockToLeave >= smoothingSettings.thresholdFinishing) && (stockToLeave < smoothingSettings.thresholdSemiFinishing)) &&
          ((verticalStockToLeave >= smoothingSettings.thresholdFinishing) && (verticalStockToLeave  < smoothingSettings.thresholdSemiFinishing))) {
          smoothing.level = smoothingSettings.semifinishing; // set semi-finishing level
        } else {
          smoothing.level = smoothingSettings.finishing; // set finishing level
        }
      }
    } else { // detemine auto smoothing level based on operation tolerance instead of stockToLeave
      if (smoothing.tolerance >= smoothingSettings.thresholdRoughing ||
          getParameter("operation:strategy", "") == "face") {
        smoothing.level = smoothingSettings.roughing; // set roughing level
      } else {
        if (((smoothing.tolerance >= smoothingSettings.thresholdSemiFinishing) && (smoothing.tolerance < smoothingSettings.thresholdRoughing))) {
          smoothing.level = smoothingSettings.semi; // set semi level
        } else if (((smoothing.tolerance >= smoothingSettings.thresholdFinishing) && (smoothing.tolerance < smoothingSettings.thresholdSemiFinishing))) {
          smoothing.level = smoothingSettings.semifinishing; // set semi-finishing level
        } else {
          smoothing.level = smoothingSettings.finishing; // set finishing level
        }
      }
    }
  }
  if (smoothing.level == -1) { // useSmoothing is disabled
    smoothing.isAllowed = false;
  } else { // do not output smoothing for the following operations
    smoothing.isAllowed = !(currentSection.getTool().type == TOOL_PROBE || currentSection.checkGroup(STRATEGY_DRILLING));
  }
  if (!smoothing.isAllowed) {
    smoothing.level = -1;
    smoothing.tolerance = -1;
  }

  switch (smoothingSettings.differenceCriteria) {
  case "level":
    smoothing.isDifferent = smoothing.level != previousLevel;
    break;
  case "tolerance":
    smoothing.isDifferent = xyzFormat.areDifferent(smoothing.tolerance, previousTolerance);
    break;
  case "both":
    smoothing.isDifferent = smoothing.level != previousLevel || xyzFormat.areDifferent(smoothing.tolerance, previousTolerance);
    break;
  default:
    error(localize("Unsupported smoothing criteria."));
    return;
  }

  // tool length compensation needs to be canceled when smoothing state/level changes
  if (smoothingSettings.cancelCompensation) {
    smoothing.cancel = !isFirstSection() && smoothing.isDifferent;
  }
}

function setSmoothing(mode) {
  if (mode == smoothing.isActive && (!mode || !smoothing.isDifferent) && !smoothing.force) {
    return; // return if smoothing is already active or is not different
  }
  if (typeof lengthCompensationActive != "undefined" && smoothingSettings.cancelCompensation) {
    validate(!lengthCompensationActive, "Length compensation is active while trying to update smoothing.");
  }
  switch (getProperty("smoothingMode")) {
  case "A":
    writeBlock(mFormat.format(mode ? 260 + smoothing.level : 269));
    break;
  case "B":
    writeBlock(mFormat.format(mode ? 280 + smoothing.level : 289));
    break;
  default:
    writeBlock(mFormat.format(298), mode ? "L" + smoothing.level : "L0");
    break;
  }
  smoothing.isActive = mode;
  smoothing.force = false;
  smoothing.isDifferent = false;
}
// End of smoothing logic

function FeedContext(id, description, feed) {
  this.id = id;
  this.description = description;
  this.feed = feed;
}

function getFeed(f) {
  if (activeMovements) {
    var feedContext = activeMovements[movement];
    if (feedContext != undefined) {
      if (!feedFormat.areDifferent(feedContext.feed, f)) {
        if (feedContext.id == currentFeedId) {
          return ""; // nothing has changed
        }
        forceFeed();
        currentFeedId = feedContext.id;
        return "F#" + (firstFeedParameter + feedContext.id);
      }
    }
    currentFeedId = undefined; // force Q feed next time
  }
  return feedOutput.format(f); // use feed value
}

function initializeActiveFeeds() {
  activeMovements = new Array();
  var movements = currentSection.getMovements();

  var id = 0;
  var activeFeeds = new Array();
  if (hasParameter("operation:tool_feedCutting")) {
    if (movements & ((1 << MOVEMENT_CUTTING) | (1 << MOVEMENT_LINK_TRANSITION) | (1 << MOVEMENT_EXTENDED))) {
      var feedContext = new FeedContext(id, localize("Cutting"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_CUTTING] = feedContext;
      if (!hasParameter("operation:tool_feedTransition")) {
        activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
      }
      activeMovements[MOVEMENT_EXTENDED] = feedContext;
    }
    ++id;
    if (movements & (1 << MOVEMENT_PREDRILL)) {
      feedContext = new FeedContext(id, localize("Predrilling"), getParameter("operation:tool_feedCutting"));
      activeMovements[MOVEMENT_PREDRILL] = feedContext;
      activeFeeds.push(feedContext);
    }
    ++id;
  }

  if (hasParameter("operation:finishFeedrate")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:finishFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedEntry")) {
    if (movements & (1 << MOVEMENT_LEAD_IN)) {
      var feedContext = new FeedContext(id, localize("Entry"), getParameter("operation:tool_feedEntry"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_IN] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LEAD_OUT)) {
      var feedContext = new FeedContext(id, localize("Exit"), getParameter("operation:tool_feedExit"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:noEngagementFeedrate")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), getParameter("operation:noEngagementFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting") &&
             hasParameter("operation:tool_feedEntry") &&
             hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), Math.max(getParameter("operation:tool_feedCutting"), getParameter("operation:tool_feedEntry"), getParameter("operation:tool_feedExit")));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  }

  /*
  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(id, localize("Reduced"), getParameter("operation:reducedFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }
*/

  if (hasParameter("operation:tool_feedRamp")) {
    if (movements & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_HELIX) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_ZIG_ZAG))) {
      var feedContext = new FeedContext(id, localize("Ramping"), getParameter("operation:tool_feedRamp"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_RAMP] = feedContext;
      activeMovements[MOVEMENT_RAMP_HELIX] = feedContext;
      activeMovements[MOVEMENT_RAMP_PROFILE] = feedContext;
      activeMovements[MOVEMENT_RAMP_ZIG_ZAG] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedPlunge")) {
    if (movements & (1 << MOVEMENT_PLUNGE)) {
      var feedContext = new FeedContext(id, localize("Plunge"), getParameter("operation:tool_feedPlunge"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_PLUNGE] = feedContext;
    }
    ++id;
  }
  if (true) { // high feed
    if ((movements & (1 << MOVEMENT_HIGH_FEED)) || (highFeedMapping != HIGH_FEED_NO_MAPPING)) {
      var feed;
      if (hasParameter("operation:highFeedrateMode") && getParameter("operation:highFeedrateMode") != "disabled") {
        feed = getParameter("operation:highFeedrate");
      } else {
        feed = this.highFeedrate;
      }
      var feedContext = new FeedContext(id, localize("High Feed"), feed);
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_HIGH_FEED] = feedContext;
      activeMovements[MOVEMENT_RAPID] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedTransition")) {
    if (movements & (1 << MOVEMENT_LINK_TRANSITION)) {
      var feedContext = new FeedContext(id, localize("Transition"), getParameter("operation:tool_feedTransition"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
    }
    ++id;
  }

  for (var i = 0; i < activeFeeds.length; ++i) {
    var feedContext = activeFeeds[i];
    writeBlock("#" + (firstFeedParameter + feedContext.id) + "=" + feedFormat.format(feedContext.feed), formatComment(feedContext.description));
  }
}

var currentWorkPlaneABC = undefined;

function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function cancelWorkPlane(force) {
  if (force) {
    gRotationModal.reset();
  }
  writeBlock(gRotationModal.format(69)); // cancel frame
  forceWorkPlane();
}

function positionABC(abc, force) {
  if (force) {
    forceABC();
    gMotionModal.reset();
  }
  var a = aOutput.format(abc.x);
  var b = bOutput.format(abc.y);
  var c = cOutput.format(abc.z);
  if (a || b || c) {
    if (!retracted) {
      writeRetract(Z);
    }
    writeBlock(gMotionModal.format(0), a, b, c);
    currentMachineABC = abc;
    setCurrentABC(abc); // required for machine simulation
  }
}

function setWorkPlane(abc) {
  if (!forceMultiAxisIndexing && is3D() && !machineConfiguration.isMultiAxisConfiguration()) {
    return; // ignore
  }

  if (!((currentWorkPlaneABC == undefined) ||
        abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
        abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
        abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z))) {
    return; // no change
  }

  if (!retracted) {
    if (false) {
      writeRetract(Z);
    }
  }

  if (useMultiAxisFeatures && !isTurningOperation) {
    if (cancelTiltFirst) {
      cancelWorkPlane();
    }
    clampAxis(abc, false);
    if (machineConfiguration.isMultiAxisConfiguration() && (useABCPrepositioning || abc.isZero())) {
      var angles = abc.isNonZero() ? getWorkPlaneMachineABC(currentSection.workPlane, false, false) : abc;
      positionABC(angles, true);
    }
    if (abc.isNonZero()) {
      gRotationModal.reset();
      writeBlock(gRotationModal.format(68.2), "X" + xyzFormat.format(0), "Y" + xyzFormat.format(0), "Z" + xyzFormat.format(0), "I" + abcFormat.format(abc.x), "J" + abcFormat.format(abc.y), "K" + abcFormat.format(abc.z)); // set frame
      writeBlock(gFormat.format(53.1)); // turn machine
    } else {
      if (!cancelTiltFirst) {
        cancelWorkPlane();
      }
    }
  } else {
    var initialPosition = getFramePosition(currentSection.getInitialPosition());
    clampAxis(abc, false);
    var _a = aOutput.format(abc.x);
    var _b = bOutput.format(abc.y);
    var _c = cOutput.format(abc.z);
    if (_a || _b || _c) {
      gMotionModal.reset();
      writeBlock(
        gMotionModal.format(0),
        conditional(machineConfiguration.isMachineCoordinate(0), _a),
        conditional(machineConfiguration.isMachineCoordinate(1), _b),
        conditional(machineConfiguration.isMachineCoordinate(2), _c)
      );
      if (!currentSection.isMultiAxis()) {
        clampAxis(abc, true);
      }
    }
  }

  currentWorkPlaneABC = abc;
}

var closestABC = false; // choose closest machine angles
var currentMachineABC;

function getWorkPlaneMachineABC(workPlane, _setWorkPlane, rotate) {
  var W = workPlane; // map to global frame
  var abc;

  if (isTurningOperation) {
    abc = getAAxisOrientationTurning(currentSection, tool.turret);
  } else {
    var abc = machineConfiguration.getABC(W);
    if (closestABC) {
      if (currentMachineABC) {
        abc = machineConfiguration.remapToABC(abc, currentMachineABC);
      } else {
        abc = machineConfiguration.getPreferredABC(abc);
      }
    } else {
      abc = machineConfiguration.getPreferredABC(abc);
    }

    try {
      abc = machineConfiguration.remapABC(abc);
      if (_setWorkPlane) {
        currentMachineABC = abc;
      }
    } catch (e) {
      error(
        localize("Machine angles not supported") + ":"
        + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
        + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
        + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
      );
    }

    var direction = machineConfiguration.getDirection(abc);
    if (!isSameDirection(direction, W.forward)) {
      error(localize("Orientation not supported."));
    }
  }

  if (!machineConfiguration.isABCSupported(abc)) {
    error(
      localize("Work plane is not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }

  if (rotate) {
    var tcp = false;
    if (tcp) {
      setRotation(W); // TCP mode
    } else {
      var O = machineConfiguration.getOrientation(abc);
      var R = machineConfiguration.getRemainingOrientation(abc, W);
      setRotation(R);
    }
  }

  return abc;
}

function getAAxisOrientationTurning(section, turret) {
  var toolAngle = hasParameter("operation:tool_angle") ? getParameter("operation:tool_angle") : 0;
  var toolOrientation = section.toolOrientation;
  if (toolAngle && toolOrientation != 0) {
    error(localize("You cannot use tool angle and tool orientation together in operation " + "\"" + (getParameter("operation-comment")) + "\""));
    return abc;
  }

  var angle = toRad(toolAngle) + toolOrientation;
  if (turret == 2) {
    angle = (Math.PI / 2) - angle; // turret 2 turns with A-axis = 90
  }
  angle *= turningAngle == 270 ? -1 : 1; // adjust A-axis tilt when turning in +Y
  if ((angle != 0) && !turningYAxis) {
    error(localize("A-axis turning is only allowed when turning along the Y-axis."));
    return abc;
  }

  var direction;
  if (Vector.dot(machineConfiguration.getAxisU().getAxis(), new Vector(1, 0, 0)) != 0) {
    direction = (machineConfiguration.getAxisU().getAxis().getCoordinate(0) >= 0) ? 1 : -1; // A-axis is the U-axis
  } else {
    direction = (machineConfiguration.getAxisV().getAxis().getCoordinate(0) >= 0) ? 1 : -1; // A-axis is the V-axis
  }
  abc = new Vector(angle * direction, 0, toRad(turningAngle));
  return abc;
}

function printProbeResults() {
  return ((currentSection.getParameter("printResults", 0) == 1) && (getProperty("probingType") == "Renishaw"));
}

function onParameter(name, value) {
  var invalid = false;
  switch (name) {
  case "action":
    var sText1 = String(value);
    var sText2 = new Array();
    sText2 = sText1.split(":");
    if (sText2.length != 2) {
      error(localize("Invalid action command: ") + value);
      return;
    }
    if (sText2[0].toUpperCase() == "TURNINGANGLE") {
      turningAngle = parseFloat(sText2[1]);
      if (isNaN(turningAngle)) {
        error(localize("TurningAngle requires a valid number."));
      }
      turningAngle = turningAngle < 0 ? turningAngle + 360 : turningAngle;
      if (turningAngle < 0 || turningAngle > 360) {
        error(localize("TurningAngle must be between 0 and 360 degrees."));
      }
    } else {
      invalid = true;
    }
  }
  if (invalid) {
    error(localize("Invalid action parameter: ") + sText2[0] + ":" + sText2[1]);
    return;
  }
}

function setTurningMode(mode, turret, init) {
  reverseCC = false;
  var turningCode = "";
  if (getProperty("useTurning")) {
    if (mode) {
      var turningCode = mTurningModal.format(142);
      if (turningCode && init) {
        // writeBlock(formatComment("ENABLE TURNING MODE"));
        mTurningModal.reset(); // turning code is output in startSpindle
      }
      if (!init) {
        return turningCode;
      }
      if (turret == 2) { // Turret 2 enables turning along Y with A=90 degrees
        turningYAxis = true;
        turningAngle = 90;
        sfmAxis = 3;
        writeComment("TURNING AT A=90 ALONG Y-AXIS");
        cOutput.disable();
      } else {
        if ((turningAngle == 90) || (turningAngle == 270)) {
          turningYAxis = true;
          sfmAxis = 2;
        } else {
          turningYAxis = false;
          sfmAxis = 1;
        }
        if (turningAngle == 0) {
          writeComment("TURNING ALONG +X");
        } else if (turningAngle == 180) {
          reverseCC = true;
          writeComment("TURNING ALONG -X");
        } else if (turningAngle == 90) {
          reverseCC = true;
          writeComment("TURNING ALONG -Y");
        } else if (turningAngle == 270) {
          writeComment("TURNING ALONG +Y");
        } else {
          reverseCC = undefined;
          writeComment(subst(localize("TURNING AT %1 DEGREES"), turningAngle * -1));
        }
        cOutput.disable();
      }
    } else {
      var code = mTurningModal.format(141);
      cOutput.enable();
      if (code) {
        writeBlock(code, formatComment("ENABLE MILLING MODE"));
        gAbsIncModal.reset();
        cOutput.reset();
        writeBlock(gAbsIncModal.format(90));
        writeBlock(gFormat.format(28), cOutput.format(0));
      }
    }
  }
  return turningCode;
}

function getPlaneMode() {
  if (isTurningOperation) {
    if (turningYAxis) {
      return 19;
    } else {
      return 18;
    }
  } else {
    return 17;
  }
}

function onSection() {
  var forceSectionRestart = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();

  var insertToolCall = forceSectionRestart || isFirstSection() ||
    currentSection.getForceToolChange && currentSection.getForceToolChange() ||
    (tool.number != getPreviousSection().getTool().number);

  retracted = false;
  var newWorkOffset = isFirstSection() || forceSectionRestart ||
    (getPreviousSection().workOffset != currentSection.workOffset); // work offset changes
  var newWorkPlane = isFirstSection() || forceSectionRestart ||
    !isSameDirection(getPreviousSection().getGlobalFinalToolAxis(), currentSection.getGlobalInitialToolAxis()) ||
    (currentSection.isOptimizedForMachine() && getPreviousSection().isOptimizedForMachine() &&
      Vector.diff(getPreviousSection().getFinalToolAxisABC(), currentSection.getInitialToolAxisABC()).length > 1e-4) ||
    (!machineConfiguration.isMultiAxisConfiguration() && currentSection.isMultiAxis()) ||
    (!getPreviousSection().isMultiAxis() && currentSection.isMultiAxis() ||
      getPreviousSection().isMultiAxis() && !currentSection.isMultiAxis()); // force newWorkPlane between indexing and simultaneous operations
  // define smoothing mode
  initializeSmoothing();

  if (insertToolCall || newWorkOffset || newWorkPlane || smoothing.isDifferent) {
    // stop spindle before retract during tool change
    if (insertToolCall && !isFirstSection()) {
      setCoolant(COOLANT_OFF);
      onCommand(COMMAND_STOP_SPINDLE);
      if (useMultiAxisFeatures) {
        writeRetract(Z);
        writeBlock(gFormat.format(49));
        cancelWorkPlane();
      }
    }

    if (!insertToolCall && (newWorkOffset || newWorkPlane)) {
      // retract to safe plane
      writeRetract(Z); // retract
      forceXYZ();
    }
    if ((insertToolCall && !isFirstSection()) || smoothing.isDifferent) {
      setSmoothing(false);
    }
  }

  isTurningOperation = (currentSection.getType() == TYPE_TURNING);
  if (!getProperty("useTurning") && isTurningOperation) {
    error(localize("Please enable the turning post property to use turning operations."));
    return;
  }

  writeln("");

  if (hasParameter("operation-comment")) {
    var comment = getParameter("operation-comment");
    if (comment) {
      writeComment(comment);
    }
  }

  if (getProperty("showNotes") && hasParameter("notes")) {
    var notes = getParameter("notes");
    if (notes) {
      var lines = String(notes).split("\n");
      var r1 = new RegExp("^[\\s]+", "g");
      var r2 = new RegExp("[\\s]+$", "g");
      for (line in lines) {
        var comment = lines[line].replace(r1, "").replace(r2, "");
        if (comment) {
          writeComment(comment);
        }
      }
    }
  }

  // set turning/milling mode
  setTurningMode(isTurningOperation, tool.turret, true);

  // wcs
  if (insertToolCall) { // force work offset when changing tool
    currentWorkOffset = undefined;
  }

  if (currentSection.workOffset != currentWorkOffset) {
    if (cancelTiltFirst) {
      cancelWorkPlane();
    }
    forceWorkPlane();
    if (!insertToolCall) {
      writeBlock(currentSection.wcs);
    }
    currentWorkOffset = currentSection.workOffset;
  }

  if (currentSection.feedMode == FEED_PER_REVOLUTION) {
    currentFeedMode = 95;
  } else {
    currentFeedMode = 94;
  }

  var abc = new Vector(0, 0, 0);
  var euler = new Vector(0, 0, 0);
  if (forceMultiAxisIndexing || !is3D() || machineConfiguration.isMultiAxisConfiguration()) { // use 5-axis indexing for multi-axis mode
    if (currentSection.isMultiAxis()) {
      forceWorkPlane();
      cancelTransformation();
      abc = currentSection.getInitialToolAxisABC();
      // clampAxis(abc, false);
    } else {
      abc = getWorkPlaneMachineABC(currentSection.workPlane, true, true);
      if (useMultiAxisFeatures) {
        euler = currentSection.workPlane.getEuler2(EULER_ZXZ_R);
        cancelTransformation();
      }
      // setWorkPlane will be called below
    }
  } else { // pure 3D
    var remaining = currentSection.workPlane;
    if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
      error(localize("Tool orientation is not supported."));
      return;
    }
    setRotation(remaining);
  }

  var spindleChanged = tool.type != TOOL_PROBE &&
    (insertToolCall || forceSpindleSpeed  || isSpindleSpeedDifferent());
  if (spindleChanged) {
    if (spindleSpeed < 0) {
      error(localize("Spindle speed out of range."));
      return;
    }
    if (spindleSpeed > maximumSpindleSpeed) {
      warning(localize("Spindle speed exceeds maximum value."));
    }
  }

  var start = getFramePosition(currentSection.getInitialPosition());
  var compensationOffset = tool.isTurningTool() ? tool.compensationOffset : tool.lengthOffset;
  if (insertToolCall) {
    forceModals();
    forceWorkPlane();

    setCoolant(COOLANT_OFF);

    if (!isFirstSection() && getProperty("optionalStop")) {
      onCommand(COMMAND_OPTIONAL_STOP);
    }

    if (tool.number > 99) {
      warning(localize("Tool number exceeds maximum value."));
    }

    var seqSave = showSequenceNumbers;
    if (getProperty("showSequenceNumbers") == "toolChange") {
      showSequenceNumbers = "true";
      // sequenceNumber = tool.number; // uncomment to use tool number as sequence number
    }
    writeBlock(
      currentSection.wcs, gAbsIncModal.format(90), gPlaneModal.format(17), gFormat.format(80), gFeedModeModal.format(currentFeedMode),
      gFormat.format(40), conditional(!isTurningOperation, gSpindleModeModal.format(97))); // safety block
    showSequenceNumbers = seqSave;
    clampAxis(abc, false, true);

    forceAny();
    var compCode = isTurningOperation ? gFormat.format(143) : (useMultiAxisFeatures ? "" : gFormat.format(43));
    writeBlock(gFormat.format(100),
      "T" + toolFormat.format(tool.number),
      conditional(!useMultiAxisFeatures, xOutput.format(start.x)),
      conditional(!useMultiAxisFeatures, yOutput.format(start.y)),
      compCode,
      conditional(!useMultiAxisFeatures, zOutput.format(start.z)),
      aOutput.format(abc.x),
      bOutput.format(abc.y),
      cOutput.format(abc.z),
      conditional(!useMultiAxisFeatures, hFormat.format(compensationOffset)),
      conditional((tool.type != TOOL_PROBE && !isTurningOperation), dFormat.format(tool.diameterOffset)),
      conditional((tool.type != TOOL_PROBE && !isTurningOperation), sOutput.format(spindleSpeed)),
      conditional((tool.type != TOOL_PROBE && !isTurningOperation), getSpindleDirection(tool.clockwise))
    );
    forceSpindleSpeed = false;

    if (!currentSection.isMultiAxis() && !useMultiAxisFeatures) {
      clampAxis(abc, true, false);
    }

    if (isTurningOperation) {
      startSpindle();
    }

    if (tool.comment) {
      writeComment(tool.comment);
    }
    var showToolZMin = false;
    if (showToolZMin) {
      if (is3D()) {
        var numberOfSections = getNumberOfSections();
        var zRange = currentSection.getGlobalZRange();
        var number = tool.number;
        for (var i = currentSection.getId() + 1; i < numberOfSections; ++i) {
          var section = getSection(i);
          if (section.getTool().number != number) {
            break;
          }
          zRange.expandToRange(section.getGlobalZRange());
        }
        writeComment(localize("ZMIN") + "=" + zRange.getMinimum());
      }
    }

    if (getProperty("preloadTool")) {
      var nextTool = getNextTool(tool.number);
      if (nextTool) {
        writeBlock("T" + toolFormat.format(nextTool.number));
      } else {
        // preload first tool
        var section = getSection(0);
        var firstToolNumber = section.getTool().number;
        if (tool.number != firstToolNumber) {
          writeBlock("T" + toolFormat.format(firstToolNumber));
        }
      }
    }
  } else {
    if (spindleChanged) {
      startSpindle();
      forceSpindleSpeed = false;
    }
  }

  // Output modal commands here
  writeBlock(gPlaneModal.format(getPlaneMode()), gAbsIncModal.format(90), gFeedModeModal.format(currentFeedMode));

  onCommand(COMMAND_START_CHIP_TRANSPORT);
  if (forceMultiAxisIndexing || !is3D() || machineConfiguration.isMultiAxisConfiguration()) {
    // writeBlock(mFormat.format(xxx)); // shortest path traverse
  }

  /*if (!insertToolCall) {
    forceXYZ();
  }*/

  if (abc !== undefined) {
    if (!useMultiAxisFeatures || isTurningOperation) {
      clampAxis(abc, false, false);
      var a = aOutput.format(abc.x);
      var b = bOutput.format(abc.y);
      var c =  cOutput.format(abc.z);
      if (a || b || c) {
        writeBlock(gMotionModal.format(0), a, b, c);
        if (!currentSection.isMultiAxis()) {
          clampAxis(abc, true, false);
        }
      }
    } else {
      setWorkPlane(euler);
      if (!currentSection.isMultiAxis()) {
        clampAxis(abc, true, false);
      }
      forceAny();
      gMotionModal.reset();
      writeBlock(gMotionModal.format(0), xOutput.format(start.x), yOutput.format(start.y));
      writeBlock(gMotionModal.format(0), gFormat.format(43), zOutput.format(start.z), hFormat.format(compensationOffset));
    }
  }
  setProbeAngle(); // output probe angle rotations if required

  // set coolant after we have positioned at Z
  setCoolant(tool.coolant);
  // add dwell for through coolant if needed
  if (tool.coolant == COOLANT_THROUGH_TOOL || tool.coolant == COOLANT_AIR_THROUGH_TOOL || tool.coolant == COOLANT_FLOOD_THROUGH_TOOL) {
    if (isFirstSection()) {
      onDwell(1);
    } else {
      var lastCoolant = getPreviousSection().getTool().coolant;
      if (!(lastCoolant == COOLANT_THROUGH_TOOL || lastCoolant == COOLANT_AIR_THROUGH_TOOL || lastCoolant == COOLANT_FLOOD_THROUGH_TOOL)) {
        onDwell(1);
      }
    }
  }

  setSmoothing(smoothing.isAllowed);

  // forceAny();
  // gMotionModal.reset();

  var initialPosition = getFramePosition(currentSection.getInitialPosition());
  if (!retracted && !insertToolCall) {
    if (xyzFormat.getResultingValue(getCurrentPosition().z) < xyzFormat.getResultingValue(initialPosition.z)) {
      writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
    }
  }

  if (tool.type != TOOL_PROBE && isFirstSection() && (getProperty("washdownCoolant") == "always")) {
    writeBlock(mFormat.format(washdownCoolant.on));
  }

  if (insertToolCall || retracted || (!isFirstSection() && getPreviousSection().isMultiAxis())) {
    var lengthOffset = tool.isTurningTool() ? tool.compensationOffset : tool.lengthOffset;
    if (lengthOffset > 99) {
      error(localize("Length offset out of range."));
      return;
    }

    writeBlock(gPlaneModal.format(getPlaneMode()));

    var x = xOutput.format(initialPosition.x);
    var y = yOutput.format(initialPosition.y);
    var z = zOutput.format(initialPosition.z);
    if (!machineConfiguration.isHeadConfiguration()) {
      if (x || y) {
        writeBlock(
          gAbsIncModal.format(90),
          gMotionModal.format(0), x, y
        );
      }
      if (z) {
        writeBlock(gMotionModal.format(0), z);
      }
    } else {
      if (x || y || z) {
        writeBlock(
          gAbsIncModal.format(90),
          gMotionModal.format(0),
          x,
          y,
          z
        );
      }
    }

    gMotionModal.reset();
  } else {
    forceXYZ();
    writeBlock(
      gAbsIncModal.format(90),
      gMotionModal.format(0),
      xOutput.format(initialPosition.x),
      yOutput.format(initialPosition.y)
    );
  }

  if (getProperty("useParametricFeed") &&
    hasParameter("operation-strategy") &&
    (getParameter("operation-strategy") != "drill") && // legacy
    !(currentSection.hasAnyCycle && currentSection.hasAnyCycle())) {
    if (!insertToolCall &&
      activeMovements &&
      (getCurrentSectionId() > 0) &&
      ((getPreviousSection().getPatternId() == currentSection.getPatternId()) && (currentSection.getPatternId() != 0))) {
      // use the current feeds
    } else {
      initializeActiveFeeds();
    }
  } else {
    activeMovements = undefined;
  }

  if (isProbeOperation()) {
    validate(probeVariables.probeAngleMethod != "G68", "You cannot probe while G68 Rotation is in effect.");
    validate(probeVariables.probeAngleMethod != "G54.4", "You cannot probe while workpiece setting error compensation G54.4 is enabled.");
    if (getProperty("probingType") == "Renishaw") {
      writeBlock(gFormat.format(65), "P" + 8832); // spin the probe on
      inspectionCreateResultsFileHeader();
    }
  }
}

function onDwell(seconds) {
  if (seconds > 99999.999) {
    warning(localize("Dwelling time is out of range."));
  }
  seconds = clamp(1, seconds, 99999999);
  writeBlock(gFeedModeModal.format(94), gFormat.format(4), "P" + secFormat.format(seconds));
}

function isSpindleSpeedDifferent() {
  if (isFirstSection()) {
    return true;
  }
  if (getPreviousSection().getTool().clockwise != tool.clockwise) {
    return true;
  }
  if (tool.getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED) {
    if ((getPreviousSection().getTool().getSpindleMode() != SPINDLE_CONSTANT_SURFACE_SPEED) ||
        rpmFormat.areDifferent(getPreviousSection().getTool().surfaceSpeed, tool.surfaceSpeed)) {
      return true;
    }
  } else {
    if ((getPreviousSection().getTool().getSpindleMode() != SPINDLE_CONSTANT_SPINDLE_SPEED) ||
        rpmFormat.areDifferent(getPreviousSection().getTool().spindleRPM, spindleSpeed)) {
      return true;
    }
  }
  return false;
}

function onSpindleSpeed(spindleSpeed) {
  writeBlock(sOutput.format(spindleSpeed));
}

function startSpindle() {
  var speed = spindleSpeed;
  var mode = 97;
  var pCode = "";
  var turningCode = isTurningOperation ? setTurningMode(isTurningOperation, tool.turret, false) : "";

  if (tool.getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED) {
    if (!isTurningOperation) {
      error(localize("Constant surface speed not supported with live tool."));
      return;
    }
    speed = tool.surfaceSpeed * ((unit == MM) ? 1 / 1000.0 : 1 / 12.0);
    mode = 96;
    var box = currentSection.getBoundingBox();
    var minSpeed;
    var maxSpeed = (tool.maximumSpindleSpeed > 0) ? Math.min(tool.maximumSpindleSpeed, maximumTurningSpeed) : maximumTurningSpeed;
    if (xFormat.getResultingValue(box.upper.x) != 0) {
      minSpeed = Math.min((tool.surfaceSpeed / (Math.PI * Math.abs(box.upper.x * 2))), maximumTurningSpeed);
    } else {
      minSpeed = 10;
    }
    gSpindleModeModal.reset();
    pCode = pOutput.format(sfmAxis);
    writeBlock(gFormat.format(92), sOutput.format(maxSpeed), qOutput.format(minSpeed));
  }
  writeBlock(turningCode, gSpindleModeModal.format(mode), pCode, sOutput.format(speed), getSpindleDirection(tool.clockwise));
}

function getSpindleDirection(clockwise) {
  if (isTurningOperation) {
    return (mFormat.format(tool.clockwise ? 303 : 304));
  } else {
    return (mFormat.format(tool.clockwise ? 3 : 4));
  }
}

function onCycle() {
  writeBlock(gPlaneModal.format(17), gFeedModeModal.format(cycleType == "thread-turning" ? 95 : 94));
}

function getCommonCycle(x, y, z, r) {
  forceXYZ(); // force xyz on first drill hole of any cycle
  return [xOutput.format(x), yOutput.format(y),
    zOutput.format(z),
    "R" + xyzFormat.format(r)];
}

/** Convert approach to sign. */
function approach(value) {
  validate((value == "positive") || (value == "negative"), "Invalid approach.");
  return (value == "positive") ? 1 : -1;
}

function setProbeAngleMethod() {
  probeVariables.probeAngleMethod = (machineConfiguration.getNumberOfAxes() < 5 || is3D()) ? (getProperty("useG54x4") ? "G54.4" : "G68") : "UNSUPPORTED";
  var axes = [machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW()];
  for (var i = 0; i < axes.length; ++i) {
    if (axes[i].isEnabled() && isSameDirection((axes[i].getAxis()).getAbsolute(), new Vector(0, 0, 1)) && axes[i].isTable()) {
      probeVariables.probeAngleMethod = "AXIS_ROT";
      break;
    }
  }
  probeVariables.outputRotationCodes = true;
}

/** Output rotation offset based on angular probing cycle. */
function setProbeAngle() {
  if (probeVariables.outputRotationCodes) {
    var probeOutputWorkOffset = currentSection.probeWorkOffset;
    validate(probeOutputWorkOffset <= 6, "Angular Probing only supports work offsets 1-6.");
    if (probeVariables.probeAngleMethod == "G68" && (Vector.diff(currentSection.getGlobalInitialToolAxis(), new Vector(0, 0, 1)).length > 1e-4)) {
      error(localize("You cannot use multi axis toolpaths while G68 Rotation is in effect."));
    }
    var validateWorkOffset = false;
    switch (probeVariables.probeAngleMethod) {
    case "G54.4":
      var param = 26000 + (probeOutputWorkOffset * 10);
      writeBlock("#" + param + "=#135");
      writeBlock("#" + (param + 1) + "=#136");
      writeBlock("#" + (param + 5) + "=#144");
      writeBlock(gFormat.format(54.4), "P" + probeOutputWorkOffset);
      break;
    case "G68":
      gRotationModal.reset();
      gAbsIncModal.reset();
      var n = xyzFormat.format(0);
      writeBlock(
        gRotationModal.format(68), gAbsIncModal.format(90),
        probeVariables.compensationXY, "Z" + n, "I" + n, "J" + n, "K" + xyzFormat.format(1), "R[#144]"
      );
      validateWorkOffset = true;
      break;
    case "AXIS_ROT":
      var param = 5200 + probeOutputWorkOffset * 20 + 5;
      writeBlock("#" + param + " = " + "[#" + param + " + #144]");
      forceWorkPlane(); // force workplane to rotate ABC in order to apply rotation offsets
      currentWorkOffset = undefined; // force WCS output to make use of updated parameters
      validateWorkOffset = true;
      break;
    default:
      error(localize("Angular Probing is not supported for this machine configuration."));
      return;
    }
    if (validateWorkOffset) {
      for (var i = currentSection.getId(); i < getNumberOfSections(); ++i) {
        if (getSection(i).workOffset != currentSection.workOffset) {
          error(localize("WCS offset cannot change while using angle rotation compensation."));
          return;
        }
      }
    }
    probeVariables.outputRotationCodes = false;
  }
}

function protectedProbeMove(_cycle, x, y, z) {
  var _x = xOutput.format(x);
  var _y = yOutput.format(y);
  var _z = zOutput.format(z);
  var _code = getProperty("probingType") == "Renishaw" ? 8810 : 8703;
  if (_z && z >= getCurrentPosition().z) {
    writeBlock(gFormat.format(65), "P" + _code, _z, getFeed(cycle.feedrate)); // protected positioning move
  }
  if (_x || _y) {
    writeBlock(gFormat.format(65), "P" + _code, _x, _y, getFeed(highFeedrate)); // protected positioning move
  }
  if (_z && z < getCurrentPosition().z) {
    writeBlock(gFormat.format(65), "P" + _code, _z, getFeed(cycle.feedrate)); // protected positioning move
  }
}

var threadStart;
var threadEnd;
function moveToThreadStart(x, y, z) {
  var cuttingAngle = 0;
  if (hasParameter("operation:infeedAngle")) {
    cuttingAngle = getParameter("operation:infeedAngle");
  }
  if (cuttingAngle != 0) {
    var zz;
    if (isFirstCyclePoint()) {
      threadStart = getCurrentPosition();
      threadEnd = new Vector(x, y, z);
    } else {
      var zz = threadStart.z - (Math.abs(threadEnd.x - x) * Math.tan(toRad(cuttingAngle)));
      writeBlock(gMotionModal.format(0), zOutput.format(zz));
      threadStart.setZ(zz);
      threadEnd = new Vector(x, y, z);
    }
  }
}

var firstCycleDepth;
var lastCycleDepth;
function onCyclePoint(x, y, z) {
  if (isProbeOperation()) {
    if (!useMultiAxisFeatures && !isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1))) {
      if (!allowIndexingWCSProbing && currentSection.strategy == "probe") {
        error(localize("Updating WCS / work offset using probing is only supported by the CNC in the WCS frame."));
        return;
      }
    }
    if (printProbeResults()) {
      writeProbingToolpathInformation(z - cycle.depth + tool.diameter / 2);
      inspectionWriteCADTransform();
      inspectionWriteWorkplaneTransform();
      if (typeof inspectionWriteVariables == "function") {
        inspectionVariables.pointNumber += 1;
      }
    }
    protectedProbeMove(cycle, x, y, z);
  }

  switch (cycleType) {
  case "thread-turning":
    var cuttingAngle = getParameter("operation:infeedAngle", 0); // Angle is not stored with tool. toDeg(tool.getTaperAngle());
    var r = -cycle.incrementalX; // positive if taper goes down - delta radius
    if (isFirstCyclePoint()) {
      pitchOutput.reset();
    }
    if (tool.turret == 2) {
      writeBlock(gInfeedModal.format(323)); // infeed along Z
    } else if (turningYAxis) {
      writeBlock(gInfeedModal.format(322)); // infeed along Y
    } else if (Math.abs(turningAngle) % 90 == 0) {
      writeBlock(gInfeedModal.format(321)); // infeed along X
    } else {
      error(localize("The turning angle must be a multiple of 90 degrees for threading cycles."));
    }
    if (getProperty("useSimpleThread") ||
        (hasParameter("operation:doMultipleThreads") && (getParameter("operation:doMultipleThreads") != 0))) {

      xOutput.reset();
      zOutput.reset();
      moveToThreadStart(x, y, z); // not necessary with Q-angle?
      writeBlock(
        gMotionModal.format(392),
        xOutput.format(x),
        yOutput.format(y),
        zOutput.format(z),
        conditional(xyzFormat.isSignificant(r), g92ROutput.format(r)),
        pitchOutput.format(cycle.pitch),
        conditional(xyzFormat.isSignificant(cuttingAngle), g92QOutput.format(cuttingAngle))
      );
    } else {
      lastCycleDepth = (lastCycleDepth == undefined || x != getCurrentPosition().x) ? getCurrentPosition().x - x :
        lastCycleDepth;
      if (isLastCyclePoint()) {
        // thread height and depth of cut
        var threadHeight = getParameter("operation:threadDepth");
        var useConstantDepth = getParameter("operation:infeedMode") == "constant";
        var firstDepthOfCut = useConstantDepth ?  threadHeight / getParameter("operation:numberOfStepdowns") :
          x + threadHeight - firstCycleDepth;
        var repeatPass = getParameter("operation:nullPass", 0) + 1;
        var cuttingAngle = getParameter("operation:infeedAngle", 30) * 2; // Angle is not stored with tool. toDeg(tool.getTaperAngle());
        cuttingAngle = cuttingAngle == 0 ? 60 : cuttingAngle;
        gCycleModal.reset();
        writeBlock(
          gCycleModal.format(376),
          xOutput.format(x),
          yOutput.format(y),
          zOutput.format(z),
          conditional(xyzFormat.isSignificant(r), threadROutput.format(r)),
          "P" + xyzFormat.format(threadHeight),
          "Q" + xyzFormat.format(firstDepthOfCut),
          pitchOutput.format(cycle.pitch),
          "D" + integerFormat.format(cuttingAngle),
          "E" + xyzFormat.format(useConstantDepth ? firstDepthOfCut : lastCycleDepth),
          "I" + integerFormat.format(repeatPass),
          "J" + xyzFormat.format(useConstantDepth ? firstDepthOfCut : lastCycleDepth),
          conditional(getParameter("operation:infeedAngle", 0) != 0, "L" + getParameter("operation:infeedAngle")), mFormat.format(323)
        );
      } else {
        firstCycleDepth = isFirstCyclePoint() ? x : firstCycleDepth;
      }
    }
    forceFeed();
    return;
  }

  if (isFirstCyclePoint() || isProbeOperation()) {
    if (!isProbeOperation()) {
      // return to initial Z which is clearance plane and set absolute mode
      repositionToCycleClearance(cycle, x, y, z);
    }

    var F = cycle.feedrate;
    var P = !cycle.dwell ? 0 : clamp(1, cycle.dwell, 99999999); // in seconds

    // tapping variables
    var threadPitch = tool.threadPitch;
    var threadsPerInch = 1.0 / threadPitch;

    switch (cycleType) {
    case "drilling":
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(81),
        getCommonCycle(x, y, z, cycle.retract),
        cyclefeedOutput.format(F)
      );
      break;
    case "counter-boring":
      if (P > 0) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(82),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P),
          cyclefeedOutput.format(F)
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(81),
          getCommonCycle(x, y, cycle.bottom, cycle.retract),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "chip-breaking":
      if ((cycle.accumulatedDepth < cycle.depth) || (P > 0)) {
        expandCyclePoint(x, y, z);
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(73),
          getCommonCycle(x, y, cycle.bottom, cycle.retract),
          "Q" + xyzFormat.format(cycle.incrementalDepth),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "deep-drilling":
      if (P > 0) {
        expandCyclePoint(x, y, z);
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(83),
          getCommonCycle(x, y, cycle.bottom, cycle.retract),
          "Q" + xyzFormat.format(cycle.incrementalDepth),
          // conditional(P > 0, "P" + secFormat.format(P)),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "tapping":
      if (!F) {
        F = tool.getTappingFeedrate();
      }
      if (getProperty("usePitchForTapping")) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 78 : 77),
          getCommonCycle(x, y, cycle.bottom, cycle.retract),
          conditional((unit == IN), "J" + xyzFormat.format(threadsPerInch)),
          conditional((unit == MM), "I" + xyzFormat.format(threadPitch)),
          conditional(getProperty("doubleTapWithdrawSpeed"), "L" + (spindleSpeed * 2 > 6000 ? 6000 : spindleSpeed * 2))
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 74 : 84),
          getCommonCycle(x, y, cycle.bottom, cycle.retract),
          "P" + secFormat.format(P),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "left-tapping":
      if (!F) {
        F = tool.getTappingFeedrate();
      }
      if (getProperty("usePitchForTapping")) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(78),
          getCommonCycle(x, y, cycle.bottom, cycle.retract),
          conditional((unit == IN), "J" + xyzFormat.format(threadsPerInch)),
          conditional((unit == MM), "I" + xyzFormat.format(threadPitch)),
          conditional(getProperty("doubleTapWithdrawSpeed"), "L" + (spindleSpeed * 2 > 6000 ? 6000 : spindleSpeed * 2))
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(74),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "right-tapping":
      if (!F) {
        F = tool.getTappingFeedrate();
      }
      if (getProperty("usePitchForTapping")) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(77),
          getCommonCycle(x, y, cycle.bottom, cycle.retract),
          conditional((unit == IN), "J" + xyzFormat.format(threadsPerInch)),
          conditional((unit == MM), "I" + xyzFormat.format(threadPitch)),
          conditional(getProperty("doubleTapWithdrawSpeed"), "L" + (spindleSpeed * 2 > 6000 ? 6000 : spindleSpeed * 2))
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(74),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "tapping-with-chip-breaking":
    case "left-tapping-with-chip-breaking":
    case "right-tapping-with-chip-breaking":
      if (cycle.accumulatedDepth < cycle.depth) {
        error(localize("Accumulated pecking depth is not supported for tapping cycles with chip breaking."));
        return;
      } else {
        if (!F) {
          F = tool.getTappingFeedrate();
        }
        if (getProperty("usePitchForTapping")) {
          writeBlock(
            gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 78 : 77),
            getCommonCycle(x, y, cycle.bottom, cycle.retract),
            "Q" + xyzFormat.format(cycle.incrementalDepth),
            conditional((unit == IN), "J" + xyzFormat.format(threadsPerInch)),
            conditional((unit == MM), "I" + xyzFormat.format(threadPitch)),
            conditional(getProperty("doubleTapWithdrawSpeed"), "L" + (spindleSpeed * 2 > 6000 ? 6000 : spindleSpeed * 2))
          );
        } else { // G84/G74 does not support chip breaking
          error(localize("Tapping with chip breaking is not supported by the G74/G84 cycle."));
        }
      }
      break;
    case "fine-boring":
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(76),
        getCommonCycle(x, y, z, cycle.retract),
        "P" + secFormat.format(P), // not optional
        "Q" + xyzFormat.format(cycle.shift),
        feedOutput.format(F)
      );
      break;
    case "back-boring":
      var dx = (gPlaneModal.getCurrent() == 19) ? cycle.backBoreDistance : 0;
      var dy = (gPlaneModal.getCurrent() == 18) ? cycle.backBoreDistance : 0;
      var dz = (gPlaneModal.getCurrent() == 17) ? cycle.backBoreDistance : 0;
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(87),
        getCommonCycle(x, y, cycle.bottom - cycle.backBoreDistance, cycle.bottom),
        "Q" + xyzFormat.format(cycle.shift),
        "P" + secFormat.format(P), // not optional
        cyclefeedOutput.format(F)
      );
      break;
    case "reaming":
      if (feedFormat.getResultingValue(cycle.feedrate) != feedFormat.getResultingValue(cycle.retractFeedrate)) {
        expandCyclePoint(x, y, z);
        break;
      }
      if (P > 0) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(89),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P),
          cyclefeedOutput.format(F)
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(85),
          getCommonCycle(x, y, z, cycle.retract),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "stop-boring":
      if (P > 0) {
        expandCyclePoint(x, y, z);
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(86),
          getCommonCycle(x, y, z, cycle.retract),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "manual-boring":
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(88),
        getCommonCycle(x, y, z, cycle.retract),
        "P" + secFormat.format(P), // not optional
        cyclefeedOutput.format(F)
      );
      break;
    case "boring":
      if (feedFormat.getResultingValue(cycle.feedrate) != feedFormat.getResultingValue(cycle.retractFeedrate)) {
        expandCyclePoint(x, y, z);
        break;
      }
      if (P > 0) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(89),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P), // not optional
          cyclefeedOutput.format(F)
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(85),
          getCommonCycle(x, y, z, cycle.retract),
          cyclefeedOutput.format(F)
        );
      }
      break;
    case "probing-x":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      writeBlock(
        gFormat.format(65), "P" + (getProperty("probingType") == "Renishaw" ? 8811 : 8700),
        conditional(getProperty("probingType") == "Blum", "A1"),
        "X" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        getProbingArguments(cycle, true)
      );
      break;
    case "probing-y":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      writeBlock(
        gFormat.format(65), "P" + (getProperty("probingType") == "Renishaw" ? 8811 : 8700),
        conditional(getProperty("probingType") == "Blum", "A1"),
        "Y" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        getProbingArguments(cycle, true)
      );
      break;
    case "probing-z":
      protectedProbeMove(cycle, x, y, Math.min(z - cycle.depth + cycle.probeClearance, cycle.retract));
      writeBlock(
        gFormat.format(65), "P" + (getProperty("probingType") == "Renishaw" ? 8811 : 8700),
        conditional(getProperty("probingType") == "Blum", "A1"),
        "Z" + xyzFormat.format(z - cycle.depth),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        getProbingArguments(cycle, true)
      );
      break;
    case "probing-x-wall":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "X" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width1),
          "X1",
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-y-wall":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Y" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y1",
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-x-channel":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width1),
          "X1",
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-x-channel-with-island":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "X" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "X1",
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-y-channel":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Y" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width1),
          "Y1",
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-y-channel-with-island":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Y" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y1",
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-xy-circular-boss":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8814,
          "D" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-xy-circular-partial-boss":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8823,
          "A" + xyzFormat.format(cycle.partialCircleAngleA),
          "B" + xyzFormat.format(cycle.partialCircleAngleB),
          "C" + xyzFormat.format(cycle.partialCircleAngleC),
          "D" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        error(localize("XY circular partial boss probing is not supported."));
      }
      break;
    case "probing-xy-circular-hole":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8814,
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-xy-circular-partial-hole":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8823,
          "A" + xyzFormat.format(cycle.partialCircleAngleA),
          "B" + xyzFormat.format(cycle.partialCircleAngleB),
          "C" + xyzFormat.format(cycle.partialCircleAngleC),
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      } else {
        error(localize("XY circular partial hole probing is not supported."));
      }
      break;
    case "probing-xy-circular-hole-with-island":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8814,
          "Z" + xyzFormat.format(z - cycle.depth),
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "R" + xyzFormat.format(-cycle.probeClearance),
          "S" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "Z" + xyzFormat.format(z - cycle.depth),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-xy-circular-partial-hole-with-island":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8823,
          "Z" + xyzFormat.format(z - cycle.depth),
          "A" + xyzFormat.format(cycle.partialCircleAngleA),
          "B" + xyzFormat.format(cycle.partialCircleAngleB),
          "C" + xyzFormat.format(cycle.partialCircleAngleC),
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        error(localize("XY circular partial hole with island probing is not supported."));
      }
      break;
    case "probing-xy-rectangular-hole":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Y" + xyzFormat.format(cycle.width2),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        error(localize("XY rectangular hole probing is not supported."));
      }
      break;
    case "probing-xy-rectangular-boss":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "X" + xyzFormat.format(cycle.width1),
          "R" + xyzFormat.format(cycle.probeClearance),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y" + xyzFormat.format(cycle.width2),
          "R" + xyzFormat.format(cycle.probeClearance),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      } else {
        zOutput.reset();
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width1),
          "X1",
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        zOutput.reset();
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          "S" + xyzFormat.format(cycle.width2),
          "Y1",
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-xy-rectangular-hole-with-island":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        writeBlock(
          gFormat.format(65), "P" + 8812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y" + xyzFormat.format(cycle.width2),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
      } else {
        error(localize("XY rectangular hole with island probing is not supported."));
      }
      break;
    case "probing-xy-inner-corner":
      if (getProperty("probingType") == "Renishaw") {
        var cornerX = x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2);
        var cornerY = y + approach(cycle.approach2) * (cycle.probeClearance + tool.diameter / 2);
        var cornerI = 0;
        var cornerJ = 0;
        if (cycle.probeSpacing !== undefined) {
          cornerI = cycle.probeSpacing;
          cornerJ = cycle.probeSpacing;
        }
        if ((cornerI != 0) && (cornerJ != 0)) {
          if (currentSection.strategy == "probe") {
            setProbeAngleMethod();
            probeVariables.compensationXY = "X[#135] Y[#136]";
          }
        }
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 8815, xOutput.format(cornerX), yOutput.format(cornerY),
          conditional(cornerI != 0, "I" + xyzFormat.format(cornerI)),
          conditional(cornerJ != 0, "J" + xyzFormat.format(cornerJ)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      } else {
        error(localize("XY inner corner probing is not supported."));
      }
      break;
    case "probing-xy-outer-corner":
      var cornerX = x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2);
      var cornerY = y + approach(cycle.approach2) * (cycle.probeClearance + tool.diameter / 2);
      var cornerI = 0;
      var cornerJ = 0;
      if (cycle.probeSpacing !== undefined) {
        cornerI = cycle.probeSpacing;
        cornerJ = cycle.probeSpacing;
      }
      if ((cornerI != 0) && (cornerJ != 0)) {
        if (currentSection.strategy == "probe") {
          setProbeAngleMethod();
          probeVariables.compensationXY = "X[#135] Y[#136]";
        }
      }
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8816, xOutput.format(cornerX), yOutput.format(cornerY),
          conditional(cornerI != 0, "I" + xyzFormat.format(cornerI)),
          conditional(cornerJ != 0, "J" + xyzFormat.format(cornerJ)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      } else {
        writeBlock(
          gFormat.format(65), "P" + 8700,
          "A1",
          xOutput.format(cornerX),
          yOutput.format(cornerY),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
      }
      break;
    case "probing-x-plane-angle":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8843,
          "X" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
          "D" + xyzFormat.format(cycle.probeSpacing),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "A" + xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 90),
          getProbingArguments(cycle, false)
        );
        if (currentSection.strategy == "probe") {
          setProbeAngleMethod();
          probeVariables.compensationXY = "X" + xyzFormat.format(0) + " Y" + xyzFormat.format(0);
        }
      } else {
        error(localize("X angle probing is not supported."));
      }
      break;
    case "probing-y-plane-angle":
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8843,
          "Y" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
          "D" + xyzFormat.format(cycle.probeSpacing),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "A" + xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 0),
          getProbingArguments(cycle, false)
        );
        if (currentSection.strategy == "probe") {
          setProbeAngleMethod();
          probeVariables.compensationXY = "X" + xyzFormat.format(0) + " Y" + xyzFormat.format(0);
        }
      } else {
        error(localize("Y angle probing is not supported."));
      }
      break;
    case "probing-xy-pcd-hole":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8819,
          "A" + xyzFormat.format(cycle.pcdStartingAngle),
          "B" + xyzFormat.format(cycle.numberOfSubfeatures),
          "C" + xyzFormat.format(cycle.widthPCD),
          "D" + xyzFormat.format(cycle.widthFeature),
          "K" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, false)
        );
        if (cycle.updateToolWear) {
          error(localize("Action -Update Tool Wear- is not supported with this cycle."));
          return;
        }
      } else {
        error(localize("XY PCD hole probing is not supported."));
      }
      break;
    case "probing-xy-pcd-boss":
      protectedProbeMove(cycle, x, y, z);
      if (getProperty("probingType") == "Renishaw") {
        writeBlock(
          gFormat.format(65), "P" + 8819,
          "A" + xyzFormat.format(cycle.pcdStartingAngle),
          "B" + xyzFormat.format(cycle.numberOfSubfeatures),
          "C" + xyzFormat.format(cycle.widthPCD),
          "D" + xyzFormat.format(cycle.widthFeature),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, false)
        );
        if (cycle.updateToolWear) {
          error(localize("Action -Update Tool Wear- is not supported with this cycle."));
          return;
        }
      } else {
        error(localize("XY PCD boss probing is not supported."));
      }
      break;
    default:
      expandCyclePoint(x, y, z);
    }
  } else {
    if (cycleExpanded) {
      expandCyclePoint(x, y, z);
    } else {
      writeBlock(xOutput.format(x), yOutput.format(y));
    }
  }
}

function getProbingArguments(cycle, updateWCS) {
  var outputWCSCode = updateWCS && currentSection.strategy == "probe";
  var probeOutputWorkOffset = currentSection.probeWorkOffset;
  if (outputWCSCode) {
    validate(probeOutputWorkOffset <= 99, "Work offset is out of range.");
    var nextWorkOffset = hasNextSection() ? getNextSection().workOffset == 0 ? 1 : getNextSection().workOffset : -1;
    if (probeOutputWorkOffset == nextWorkOffset) {
      currentWorkOffset = undefined;
    }
  }
  if (getProperty("probingType") == "Renishaw") {
    return [
      (cycle.angleAskewAction == "stop-message" ? "B" + xyzFormat.format(cycle.toleranceAngle ? cycle.toleranceAngle : 0) : undefined),
      ((cycle.updateToolWear && cycle.toolWearErrorCorrection < 100) ? "F" + xyzFormat.format(cycle.toolWearErrorCorrection ? cycle.toolWearErrorCorrection / 100 : 100) : undefined),
      (cycle.wrongSizeAction == "stop-message" ? "H" + xyzFormat.format(cycle.toleranceSize ? cycle.toleranceSize : 0) : undefined),
      (cycle.outOfPositionAction == "stop-message" ? "M" + xyzFormat.format(cycle.tolerancePosition ? cycle.tolerancePosition : 0) : undefined),
      ((cycle.updateToolWear && cycleType == "probing-z") ? "T" + xyzFormat.format(cycle.toolLengthOffset) : undefined),
      ((cycle.updateToolWear && cycleType !== "probing-z") ? "T" + xyzFormat.format(cycle.toolDiameterOffset) : undefined),
      (cycle.updateToolWear ? "V" + xyzFormat.format(cycle.toolWearUpdateThreshold ? cycle.toolWearUpdateThreshold : 0) : undefined),
      (cycle.printResults ? "W" + xyzFormat.format(1 + cycle.incrementComponent) : undefined), // 1 for advance feature, 2 for reset feature count and advance component number. first reported result in a program should use W2.
      conditional(outputWCSCode, "S" + probeWCSFormat.format(probeOutputWorkOffset > 6 ? (probeOutputWorkOffset - 6 + 100) : probeOutputWorkOffset))
    ];
  } else {
    return [
      (cycle.wrongSizeAction == "stop-message" ? "T" + xyzFormat.format(cycle.toleranceSize ? cycle.toleranceSize : 0) : undefined),
      (cycle.outOfPositionAction == "stop-message" ? "T" + xyzFormat.format(cycle.tolerancePosition ? -1 * cycle.tolerancePosition : 0) : undefined),
      (cycle.updateToolWear ? "E" + xyzFormat.format(cycle.toolWearNumber) : undefined),
      conditional(outputWCSCode, "W" + probeWCSFormat.format(probeOutputWorkOffset > 6 ? -1 * (probeOutputWorkOffset - 6) : (probeOutputWorkOffset + 53)))
    ];
  }
}

function onCycleEnd() {
  if (isProbeOperation()) {
    zOutput.reset();
    gMotionModal.reset();
    if (getProperty("probingType") == "Renishaw") {
      writeBlock(gFormat.format(65), "P" + 8810, zOutput.format(cycle.retract)); // protected retract move
    } else {
      writeBlock(gFormat.format(65), "P" + 8703, zOutput.format(cycle.retract)); // protected retract move
    }
  } else if (!cycleExpanded) {
    writeBlock(gCycleModal.format(80), gFeedModeModal.format(94));
    zOutput.reset();
  }
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  if (radiusCompensation != RADIUS_COMPENSATION_OFF && reverseCC == undefined) {
    error(localize("Radius compensation is not supported outside of ZX or YZ Plane during turning."));
  }
  pendingRadiusCompensation = radiusCompensation;
}

function onRapid(_x, _y, _z) {
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      error(localize("Radius compensation mode cannot be changed at rapid traversal."));
      return;
    }
    writeBlock(gMotionModal.format(0), x, y, z);
    forceFeed();
  }
}

var resetFeed = false;
function onLinear(_x, _y, _z, feed) {
  if (isSpeedFeedSynchronizationActive() && isTurningOperation) {
    resetFeed = true;
    var threadPitch = getParameter("operation:threadPitch");
    var threadsPerInch = 1.0 / threadPitch; // per mm for metric
    writeBlock(gMotionModal.format(33), xOutput.format(_x), yOutput.format(_y), zOutput.format(_z), pitchOutput.format(1 / threadsPerInch));
    return;
  }
  if (resetFeed) {
    resetFeed = false;
    forceFeed();
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var f = getFeed(feed);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      var d = isTurningOperation ? tool.compensationOffset : tool.diameterOffset;
      if (d > 99) {
        warning(localize("The diameter offset exceeds the maximum value."));
      }
      writeBlock(gPlaneModal.format(getPlaneMode()));

      var base = isTurningOperation ? 100 : 0;
      var ccLeft = (reverseCC) ? base + 42 : base + 41;
      var ccRight = (reverseCC) ? base + 41 : base + 42;
      switch (radiusCompensation) {
      case RADIUS_COMPENSATION_LEFT:
        dOutput.reset();
        writeBlock(gFeedModeModal.format(currentFeedMode), gMotionModal.format(1), gFormat.format(ccLeft), x, y, z, dOutput.format(d), f);
        break;
      case RADIUS_COMPENSATION_RIGHT:
        dOutput.reset();
        writeBlock(gFeedModeModal.format(currentFeedMode), gMotionModal.format(1), gFormat.format(ccRight), x, y, z, dOutput.format(d), f);
        break;
      default:
        writeBlock(gFeedModeModal.format(currentFeedMode), gMotionModal.format(1), gFormat.format(40), x, y, z, f);
      }
    } else {
      writeBlock(gFeedModeModal.format(currentFeedMode), gMotionModal.format(1), x, y, z, f);
    }
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(currentFeedMode), gMotionModal.format(1), f);
    }
  }
}

function onRapid5D(_x, _y, _z, _a, _b, _c) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode cannot be changed at rapid traversal."));
    return;
  }
  if (currentSection.isOptimizedForMachine()) {
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var a = aOutput.format(_a);
    var b = bOutput.format(_b);
    var c = cOutput.format(_c);
    if (x || y || z || a || b || c) {
      writeBlock(gMotionModal.format(0), x, y, z, a, b, c);
    }
  } else {
    forceXYZ();
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var i = ijkFormat.format(_a);
    var j = ijkFormat.format(_b);
    var k = ijkFormat.format(_c);
    writeBlock(gMotionModal.format(0), x, y, z, "I" + i, "J" + j, "K" + k);
  }
  forceFeed();
}

function onLinear5D(_x, _y, _z, _a, _b, _c, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }

  if (currentSection.isOptimizedForMachine()) {
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var a = aOutput.format(_a);
    var b = bOutput.format(_b);
    var c = cOutput.format(_c);

    // get feedrate number
    var f = {frn:0, fmode:0};
    if (a || b || c) {
      f = getMultiaxisFeed(_x, _y, _z, _a, _b, _c, feed);
      if (getProperty("useInverseTime")) {
        f.frn = inverseTimeOutput.format(f.frn);
      } else {
        f.frn = feedOutput.format(f.frn);
      }
    } else {
      f.frn = feedOutput.format(feed);
      f.fmode = currentFeedMode;
    }

    if (x || y || z || a || b || c) {
      writeBlock(gFeedModeModal.format(f.fmode), gMotionModal.format(1), x, y, z, a, b, c, f.frn);
    } else if (f) {
      if (getNextRecord().isMotion()) { // try not to output feed without motion
        forceFeed(); // force feed on next line
      } else {
        writeBlock(gFeedModeModal.format(f.fmode), gMotionModal.format(1), f.frn);
      }
    }
  } else {
    forceXYZ();
    var x = xOutput.format(_x);
    var y = yOutput.format(_y);
    var z = zOutput.format(_z);
    var i = ijkFormat.format(_a);
    var j = ijkFormat.format(_b);
    var k = ijkFormat.format(_c);
    var f = getFeed(feed);
    if (x || y || z || i || j || k) {
      writeBlock(gFeedModeModal.format(currentFeedMode), gMotionModal.format(1), x, y, z, "I" + i, "J" + j, "K" + k, f);
    } else if (f) {
      if (getNextRecord().isMotion()) { // try not to output feed without motion
        forceFeed(); // force feed on next line
      } else {
        writeBlock(gFeedModeModal.format(currentFeedMode), gMotionModal.format(1), f);
      }
    }
  }
}

// Start of multi-axis feedrate logic
/***** You can add 'getProperty("useInverseTime'") if desired. *****/
/***** 'previousABC' can be added throughout to maintain previous rotary positions. Required for Mill/Turn machines. *****/
/***** 'headOffset' should be defined when a head rotary axis is defined. *****/
/***** The feedrate mode must be included in motion block output (linear, circular, etc.) for Inverse Time feedrate support. *****/
var dpmBPW = 0.1; // ratio of rotary accuracy to linear accuracy for DPM calculations
var inverseTimeUnits = 1.0; // 1.0 = minutes, 60.0 = seconds
var maxInverseTime = 9999.999; // maximum value to output for Inverse Time feeds
var maxDPM = 9999.99; // maximum value to output for DPM feeds
var useInverseTimeFeed = false; // use 1/T feeds
var inverseTimeFormat = createFormat({decimals:3, forceDecimal:true});
var inverseTimeOutput = createVariable({prefix:"F", force:true}, inverseTimeFormat);
var previousDPMFeed = 0; // previously output DPM feed
var dpmFeedToler = 0.5; // tolerance to determine when the DPM feed has changed
// var previousABC = new Vector(0, 0, 0); // previous ABC position if maintained in post, don't define if not used
var forceOptimized = undefined; // used to override optimized-for-angles points (XZC-mode)

/** Calculate the multi-axis feedrate number. */
function getMultiaxisFeed(_x, _y, _z, _a, _b, _c, feed) {
  var f = {frn:0, fmode:0};
  if (feed <= 0) {
    error(localize("Feedrate is less than or equal to 0."));
    return f;
  }

  var length = getMoveLength(_x, _y, _z, _a, _b, _c);

  if (getProperty("useInverseTime")) { // inverse time
    f.frn = getInverseTime(length.tool, feed);
    f.fmode = 93;
    feedOutput.reset();
  } else { // degrees per minute
    f.frn = getFeedDPM(length, feed);
    f.fmode = 94;
  }
  return f;
}

/** Returns point optimization mode. */
function getOptimizedMode() {
  if (forceOptimized != undefined) {
    return forceOptimized;
  }
  // return (currentSection.getOptimizedTCPMode() != 0); // TAG:doesn't return correct value
  return true; // always return false for non-TCP based heads
}

/** Calculate the DPM feedrate number. */
function getFeedDPM(_moveLength, _feed) {
  if ((_feed == 0) || (_moveLength.tool < 0.0001) || (toDeg(_moveLength.abcLength) < 0.0005)) {
    previousDPMFeed = 0;
    return _feed;
  }
  var moveTime = _moveLength.tool / _feed;
  if (moveTime == 0) {
    previousDPMFeed = 0;
    return _feed;
  }

  var dpmFeed;
  var tcp = false; // !getOptimizedMode() && (forceOptimized == undefined);   // set to false for rotary heads
  if (tcp) { // TCP mode is supported, output feed as FPM
    dpmFeed = _feed;
  } else if (false) { // standard DPM
    dpmFeed = Math.min(toDeg(_moveLength.abcLength) / moveTime, maxDPM);
    if (Math.abs(dpmFeed - previousDPMFeed) < dpmFeedToler) {
      dpmFeed = previousDPMFeed;
    }
  } else if (true) { // combination FPM/DPM
    var length = Math.sqrt(Math.pow(_moveLength.xyzLength, 2.0) + Math.pow((toDeg(_moveLength.abcLength) * dpmBPW), 2.0));
    dpmFeed = Math.min((length / moveTime), maxDPM);
    if (Math.abs(dpmFeed - previousDPMFeed) < dpmFeedToler) {
      dpmFeed = previousDPMFeed;
    }
  } else { // machine specific calculation
    dpmFeed = _feed;
  }
  previousDPMFeed = dpmFeed;
  return dpmFeed;
}

/** Calculate the Inverse time feedrate number. */
function getInverseTime(_length, _feed) {
  var inverseTime;
  if (_length < 1.e-6) { // tool doesn't move
    if (typeof maxInverseTime === "number") {
      inverseTime = maxInverseTime;
    } else {
      inverseTime = 999999;
    }
  } else {
    inverseTime = _feed / _length / inverseTimeUnits;
    if (typeof maxInverseTime === "number") {
      if (inverseTime > maxInverseTime) {
        inverseTime = maxInverseTime;
      }
    }
  }
  return inverseTime;
}

/** Calculate radius for each rotary axis. */
function getRotaryRadii(startTool, endTool, startABC, endABC) {
  var radii = new Vector(0, 0, 0);
  var startRadius;
  var endRadius;
  var axis = new Array(machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW());
  for (var i = 0; i < 3; ++i) {
    if (axis[i].isEnabled()) {
      var startRadius = getRotaryRadius(axis[i], startTool, startABC);
      var endRadius = getRotaryRadius(axis[i], endTool, endABC);
      radii.setCoordinate(axis[i].getCoordinate(), Math.max(startRadius, endRadius));
    }
  }
  return radii;
}

/** Calculate the distance of the tool position to the center of a rotary axis. */
function getRotaryRadius(axis, toolPosition, abc) {
  if (!axis.isEnabled()) {
    return 0;
  }

  var direction = axis.getEffectiveAxis();
  var normal = direction.getNormalized();
  // calculate the rotary center based on head/table
  var center;
  var radius;
  if (axis.isHead()) {
    var pivot;
    if (typeof headOffset === "number") {
      pivot = headOffset;
    } else {
      pivot = tool.getBodyLength();
    }
    if (axis.getCoordinate() == machineConfiguration.getAxisU().getCoordinate()) { // rider
      center = Vector.sum(toolPosition, Vector.product(machineConfiguration.getDirection(abc), pivot));
      center = Vector.sum(center, axis.getOffset());
      radius = Vector.diff(toolPosition, center).length;
    } else { // carrier
      var angle = abc.getCoordinate(machineConfiguration.getAxisU().getCoordinate());
      radius = Math.abs(pivot * Math.sin(angle));
      radius += axis.getOffset().length;
    }
  } else {
    center = axis.getOffset();
    var d1 = toolPosition.x - center.x;
    var d2 = toolPosition.y - center.y;
    var d3 = toolPosition.z - center.z;
    var radius = Math.sqrt(
      Math.pow((d1 * normal.y) - (d2 * normal.x), 2.0) +
      Math.pow((d2 * normal.z) - (d3 * normal.y), 2.0) +
      Math.pow((d3 * normal.x) - (d1 * normal.z), 2.0)
    );
  }
  return radius;
}

/** Calculate the linear distance based on the rotation of a rotary axis. */
function getRadialDistance(radius, startABC, endABC) {
  // calculate length of radial move
  var delta = Math.abs(endABC - startABC);
  if (delta > Math.PI) {
    delta = 2 * Math.PI - delta;
  }
  var radialLength = (2 * Math.PI * radius) * (delta / (2 * Math.PI));
  return radialLength;
}

/** Calculate tooltip, XYZ, and rotary move lengths. */
function getMoveLength(_x, _y, _z, _a, _b, _c) {
  // get starting and ending positions
  var moveLength = {};
  var startTool;
  var endTool;
  var startXYZ;
  var endXYZ;
  var startABC;
  if (typeof previousABC !== "undefined") {
    startABC = new Vector(previousABC.x, previousABC.y, previousABC.z);
  } else {
    startABC = getCurrentDirection();
  }
  var endABC = new Vector(_a, _b, _c);

  if (!getOptimizedMode()) { // calculate XYZ from tool tip
    startTool = getCurrentPosition();
    endTool = new Vector(_x, _y, _z);
    startXYZ = startTool;
    endXYZ = endTool;

    // adjust points for tables
    if (!machineConfiguration.getTableABC(startABC).isZero() || !machineConfiguration.getTableABC(endABC).isZero()) {
      startXYZ = machineConfiguration.getOrientation(machineConfiguration.getTableABC(startABC)).getTransposed().multiply(startXYZ);
      endXYZ = machineConfiguration.getOrientation(machineConfiguration.getTableABC(endABC)).getTransposed().multiply(endXYZ);
    }

    // adjust points for heads
    if (machineConfiguration.getAxisU().isEnabled() && machineConfiguration.getAxisU().isHead()) {
      if (typeof getOptimizedHeads === "function") { // use post processor function to adjust heads
        startXYZ = getOptimizedHeads(startXYZ.x, startXYZ.y, startXYZ.z, startABC.x, startABC.y, startABC.z);
        endXYZ = getOptimizedHeads(endXYZ.x, endXYZ.y, endXYZ.z, endABC.x, endABC.y, endABC.z);
      } else { // guess at head adjustments
        var startDisplacement = machineConfiguration.getDirection(startABC);
        startDisplacement.multiply(headOffset);
        var endDisplacement = machineConfiguration.getDirection(endABC);
        endDisplacement.multiply(headOffset);
        startXYZ = Vector.sum(startTool, startDisplacement);
        endXYZ = Vector.sum(endTool, endDisplacement);
      }
    }
  } else { // calculate tool tip from XYZ, heads are always programmed in TCP mode, so not handled here
    startXYZ = getCurrentPosition();
    endXYZ = new Vector(_x, _y, _z);
    startTool = machineConfiguration.getOrientation(machineConfiguration.getTableABC(startABC)).multiply(startXYZ);
    endTool = machineConfiguration.getOrientation(machineConfiguration.getTableABC(endABC)).multiply(endXYZ);
  }

  // calculate axes movements
  moveLength.xyz = Vector.diff(endXYZ, startXYZ).abs;
  moveLength.xyzLength = moveLength.xyz.length;
  moveLength.abc = Vector.diff(endABC, startABC).abs;
  for (var i = 0; i < 3; ++i) {
    if (moveLength.abc.getCoordinate(i) > Math.PI) {
      moveLength.abc.setCoordinate(i, 2 * Math.PI - moveLength.abc.getCoordinate(i));
    }
  }
  moveLength.abcLength = moveLength.abc.length;

  // calculate radii
  moveLength.radius = getRotaryRadii(startTool, endTool, startABC, endABC);

  // calculate the radial portion of the tool tip movement
  var radialLength = Math.sqrt(
    Math.pow(getRadialDistance(moveLength.radius.x, startABC.x, endABC.x), 2.0) +
    Math.pow(getRadialDistance(moveLength.radius.y, startABC.y, endABC.y), 2.0) +
    Math.pow(getRadialDistance(moveLength.radius.z, startABC.z, endABC.z), 2.0)
  );

  // calculate the tool tip move length
  // tool tip distance is the move distance based on a combination of linear and rotary axes movement
  moveLength.tool = moveLength.xyzLength + radialLength;

  // debug
  if (false) {
    writeComment("DEBUG - tool   = " + moveLength.tool);
    writeComment("DEBUG - xyz    = " + moveLength.xyz);
    var temp = Vector.product(moveLength.abc, 180 / Math.PI);
    writeComment("DEBUG - abc    = " + temp);
    writeComment("DEBUG - radius = " + moveLength.radius);
  }
  return moveLength;
}
// End of multi-axis feedrate logic

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (isSpeedFeedSynchronizationActive()) {
    error(localize("Speed-feed synchronization is not supported for circular moves."));
    return;
  }

  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();
  var directionCode = clockwise ? 2 : 3;

  if (isFullCircle()) {
    if (getProperty("useRadius") || isHelical()) { // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gFeedModeModal.format(currentFeedMode), gAbsIncModal.format(90), gPlaneModal.format(17), gMotionModal.format(directionCode), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gFeedModeModal.format(currentFeedMode), gAbsIncModal.format(90), gPlaneModal.format(18), gMotionModal.format(directionCode), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gFeedModeModal.format(currentFeedMode), gAbsIncModal.format(90), gPlaneModal.format(19), gMotionModal.format(directionCode), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else if (!getProperty("useRadius")) {
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gFeedModeModal.format(currentFeedMode), gAbsIncModal.format(90), gPlaneModal.format(17), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gFeedModeModal.format(currentFeedMode), gAbsIncModal.format(90), gPlaneModal.format(18), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gFeedModeModal.format(currentFeedMode), gAbsIncModal.format(90), gPlaneModal.format(19), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else { // use radius mode
    var r = getCircularRadius();
    if (toDeg(getCircularSweep()) > 180) {
      r = -r; // allow up to <360 deg arcs
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gFeedModeModal.format(currentFeedMode), gPlaneModal.format(17), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gFeedModeModal.format(currentFeedMode), gPlaneModal.format(18), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gFeedModeModal.format(currentFeedMode), gPlaneModal.format(19), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  }
}

var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;
var forceCoolant = false;
var firstThrough = true;
var addDwell = false;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    if (singleLineCoolant) {
      writeBlock(coolantCodes.join(getWordSeparator()));
    } else {
      for (var c in coolantCodes) {
        writeBlock(coolantCodes[c]);
      }
    }
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant) {
  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (tool.type == TOOL_PROBE) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }
  if (coolant == currentCoolantMode && (!forceCoolant || coolant == COOLANT_OFF)) {
    return undefined; // coolant is already active
  }
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF) && (coolantOff != undefined) && !forceCoolant) {
    if (Array.isArray(coolantOff)) {
      for (var i in coolantOff) {
        multipleCoolantBlocks.push(coolantOff[i]);
      }
    } else {
      multipleCoolantBlocks.push(coolantOff);
    }
  }
  forceCoolant = false;

  var m;
  var coolantCodes = {};
  for (var c in coolants) { // find required coolant codes into the coolants array
    if (coolants[c].id == coolant) {
      coolantCodes.on = coolants[c].on;
      if (coolants[c].off != undefined) {
        coolantCodes.off = coolants[c].off;
        break;
      } else {
        for (var i in coolants) {
          if (coolants[i].id == COOLANT_OFF) {
            coolantCodes.off = coolants[i].off;
            break;
          }
        }
      }
    }
  }
  if (coolant == COOLANT_OFF) {
    m = !coolantOff ? coolantCodes.off : coolantOff; // use the default coolant off command when an 'off' value is not specified
  } else {
    coolantOff = coolantCodes.off;
    m = coolantCodes.on;
  }

  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  } else {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(m[i]);
      }
    } else {
      multipleCoolantBlocks.push(m);
    }
    currentCoolantMode = coolant;
    for (var i in multipleCoolantBlocks) {
      if (typeof multipleCoolantBlocks[i] == "number") {
        multipleCoolantBlocks[i] = mFormat.format(multipleCoolantBlocks[i]);
      }
    }
    return multipleCoolantBlocks; // return the single formatted coolant value
  }
  return undefined;
}

var mapCommand = {
  COMMAND_STOP                    : 0,
  COMMAND_OPTIONAL_STOP           : 1,
  COMMAND_END                     : 2,
  COMMAND_SPINDLE_CLOCKWISE       : 3,
  COMMAND_SPINDLE_COUNTERCLOCKWISE: 4,
  COMMAND_ORIENTATE_SPINDLE       : 19
};

function onCommand(command) {
  switch (command) {
  case COMMAND_STOP:
    writeBlock(mFormat.format(0));
    forceSpindleSpeed = true;
    forceCoolant = true;
    return;
  case COMMAND_OPTIONAL_STOP:
    writeBlock(mFormat.format(1));
    forceSpindleSpeed = true;
    forceCoolant = true;
    return;
  case COMMAND_START_SPINDLE:
    onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
    return;
  case COMMAND_SPINDLE_CLOCKWISE:
    writeBlock(mFormat.format(isTurningOperation ? 303 : 3));
    return;
  case COMMAND_SPINDLE_COUNTERCLOCKWISE:
    writeBlock(mFormat.format(isTurningOperation ? 304 : 4));
    return;
  case COMMAND_STOP_SPINDLE:
    writeBlock(mFormat.format(isTurningOperation ? 305 : 5));
    return;
  case COMMAND_LOCK_MULTI_AXIS:
    writeBlock(mFormat.format(443), formatComment("CLAMP A-AXIS"));
    writeBlock(mFormat.format(445), formatComment("CLAMP C-AXIS"));
    aAxisIsClamped = true;
    cAxisIsClamped = true;
    return;
  case COMMAND_UNLOCK_MULTI_AXIS:
    writeBlock(mFormat.format(442), formatComment("UNCLAMP A-AXIS"));
    writeBlock(mFormat.format(444), formatComment("UNCLAMP C-AXIS"));
    aAxisIsClamped = false;
    cAxisIsClamped = false;
    return;
  case COMMAND_START_CHIP_TRANSPORT:
    return;
  case COMMAND_STOP_CHIP_TRANSPORT:
    return;
  case COMMAND_BREAK_CONTROL:
    return;
  case COMMAND_TOOL_MEASURE:
    return;
  case COMMAND_ACTIVATE_SPEED_FEED_SYNCHRONIZATION:
    return;
  case COMMAND_DEACTIVATE_SPEED_FEED_SYNCHRONIZATION:
    return;
  }

  var stringId = getCommandStringId(command);
  var mcode = mapCommand[stringId];
  if (mcode != undefined) {
    writeBlock(mFormat.format(mcode));
  } else {
    onUnsupportedCommand(command);
  }
}

var aAxisIsClamped = true;
var cAxisIsClamped = true;
function clampAxis(abc, clamp, force) {
  if (clamp) { // clamp axes
    if (!aAxisIsClamped || force) {
      writeBlock(mFormat.format(443), formatComment("CLAMP A-AXIS"));
      aAxisIsClamped = true;
    }
    if (!cAxisIsClamped || force) {
      if (cOutput.isEnabled()) {
        writeBlock(mFormat.format(445), formatComment("CLAMP C-AXIS"));
        cAxisIsClamped = true;
      }
    }
  } else { // unclamp axes
    var unclampA = false;
    var unclampC = false;
    if (currentSection.isMultiAxis()) {
      unclampA = abcFormat.areDifferent(currentSection.getLowerToolAxisABC().x, currentSection.getUpperToolAxisABC().x);
      unclampC = abcFormat.areDifferent(currentSection.getLowerToolAxisABC().z, currentSection.getUpperToolAxisABC().z);
    } else {
      unclampA = aAxisIsClamped && abcFormat.areDifferent(abc.x, aOutput.getCurrent());
      unclampC = cAxisIsClamped && abcFormat.areDifferent(abc.z, cOutput.getCurrent()) && !isTurningOperation;
    }
    if ((aAxisIsClamped && unclampA) || force) {
      writeBlock(mFormat.format(442), formatComment("UNCLAMP A-AXIS"));
      aAxisIsClamped = false;
    }
    if ((cAxisIsClamped && unclampC) || force) {
      if (cOutput.isEnabled()) {
        writeBlock(mFormat.format(444), formatComment("UNCLAMP C-AXIS"));
        cAxisIsClamped = false;
      }
    }
  }
  forceClampCodes = false;
}

function onSectionEnd() {
  if (currentSection.isMultiAxis()) {
    writeBlock(gFeedModeModal.format(currentFeedMode)); // inverse time feed off
  }

  if (currentSection.isMultiAxis() && !currentSection.isOptimizedForMachine()) {
    writeBlock(gFormat.format(49));
  }
  // writeBlock(gPlaneModal.format(17));

  if (((getCurrentSectionId() + 1) >= getNumberOfSections()) ||
      (tool.number != getNextSection().getTool().number)) {
    onCommand(COMMAND_BREAK_CONTROL);
  }

  // the code below gets the machine angles from previous operation.  closestABC must also be set to true
  if (currentSection.isMultiAxis() && currentSection.isOptimizedForMachine()) {
    currentMachineABC = currentSection.getFinalToolAxisABC();
  }

  if (tool.type != TOOL_PROBE && getProperty("washdownCoolant") == "operationEnd") {
    writeBlock(mFormat.format(washdownCoolant.on));
    writeBlock(mFormat.format(washdownCoolant.off));
  }
  // forceAny();

  if (currentSection.isMultiAxis()) {
    if (!hasNextSection() || !getNextSection().isMultiAxis()) {
      clampAxis(currentSection.getFinalToolAxisABC(), true);
    }
  }
  if (isProbeOperation()) {
    if (getProperty("probingType") == "Renishaw") {
      writeBlock(gFormat.format(65), "P" + 8833); // spin the probe off
      if (probeVariables.probeAngleMethod != "G68") {
        setProbeAngle(); // output probe angle rotations if required
      }
    }
  }
  turningAngle = saveTurningAngle;
}

/** Output block to do safe retract and/or move to home position. */
function writeRetract() {
  var words = []; // store all retracted axes in an array
  var retractAxes = new Array(false, false, false);
  var method = getProperty("safePositionMethod");
  if (method == "clearanceHeight") {
    if (!is3D()) {
      error(localize("Safe retract option 'Clearance Height' is only supported when all operations are along the setup Z-axis."));
    }
    return;
  }
  validate(arguments.length != 0, "No axis specified for writeRetract().");

  for (i in arguments) {
    retractAxes[arguments[i]] = true;
  }
  if ((retractAxes[0] || retractAxes[1]) && !retracted) { // retract Z first before moving to X/Y home
    error(localize("Retracting in X/Y is not possible without being retracted in Z."));
    return;
  }

  // special condition
  if (retractAxes[2]) { // Z doesn't use G53
    method = "G28";
  }
  if (gRotationModal.getCurrent() == 68) { // cancel G68 before retracting
    cancelWorkPlane(true);
  }
  // define home positions
  var _xHome;
  var _yHome;
  var _zHome;
  if (method == "G28") {
    _xHome = toPreciseUnit(0, MM);
    _yHome = toPreciseUnit(0, MM);
    _zHome = toPreciseUnit(0, MM);
  } else {
    _xHome = machineConfiguration.hasHomePositionX() ? machineConfiguration.getHomePositionX() : getProperty("xHomePosition");
    _yHome = machineConfiguration.hasHomePositionY() ? machineConfiguration.getHomePositionY() : toPreciseUnit(0, MM);
    _zHome = machineConfiguration.getRetractPlane() != 0 ? machineConfiguration.getRetractPlane() : toPreciseUnit(0, MM);
  }
  for (var i = 0; i < arguments.length; ++i) {
    switch (arguments[i]) {
    case X:
      words.push("X" + xyzFormat.format(_xHome));
      xOutput.reset();
      break;
    case Y:
      words.push("Y" + xyzFormat.format(_yHome));
      yOutput.reset();
      break;
    case Z:
      words.push("Z" + xyzFormat.format(_zHome));
      zOutput.reset();
      retracted = true;
      break;
    default:
      error(localize("Unsupported axis specified for writeRetract()."));
      return;
    }
  }
  if (words.length > 0) {
    switch (method) {
    case "G28":
      gAbsIncModal.reset();
      writeBlock(gFormat.format(28), gAbsIncModal.format(91), words);
      writeBlock(gAbsIncModal.format(90));
      break;
    case "G53":
      gAbsIncModal.reset();
      writeBlock(gAbsIncModal.format(90), gFormat.format(53), gMotionModal.format(0), words);
      break;
    default:
      error(localize("Unsupported safe position method."));
      return;
    }
  }
}

var isDPRNTopen = false;
function inspectionCreateResultsFileHeader() {
  if (isDPRNTopen) {
    if (!getProperty("singleResultsFile")) {
      writeln("DPRNT[END]");
      writeBlock("PCLOS");
      isDPRNTopen = false;
    }
  }

  if (isProbeOperation() && !printProbeResults()) {
    return; // if print results is not desired by probe/ probeWCS
  }

  if (!isDPRNTopen) {
    writeBlock("PCLOS");
    writeBlock("POPEN");
    // check for existence of none alphanumeric characters but not spaces
    var resFile;
    if (getProperty("singleResultsFile")) {
      resFile = getParameter("job-description") + "-RESULTS";
    } else {
      resFile = getParameter("operation-comment") + "-RESULTS";
    }
    resFile = resFile.replace(/:/g, "-");
    resFile = resFile.replace(/[^a-zA-Z0-9 -]/g, "");
    resFile = resFile.replace(/\s/g, "-");
    writeln("DPRNT[START]");
    writeln("DPRNT[RESULTSFILE*" + resFile + "]");
    if (hasGlobalParameter("document-id")) {
      writeln("DPRNT[DOCUMENTID*" + getGlobalParameter("document-id") + "]");
    }
    if (hasGlobalParameter("model-version")) {
      writeln("DPRNT[MODELVERSION*" + getGlobalParameter("model-version") + "]");
    }
  }
  if (isProbeOperation() && printProbeResults()) {
    isDPRNTopen = true;
  }
}

function getPointNumber() {
  if (typeof inspectionWriteVariables == "function") {
    return (inspectionVariables.pointNumber);
  } else {
    return ("#122[60]");
  }
}

function inspectionWriteCADTransform() {
  var cadOrigin = currentSection.getModelOrigin();
  var cadWorkPlane = currentSection.getModelPlane().getTransposed();
  var cadEuler = cadWorkPlane.getEuler2(EULER_XYZ_S);
  writeln(
    "DPRNT[G331" +
    "*N" + getPointNumber() +
    "*A" + abcFormat.format(cadEuler.x) +
    "*B" + abcFormat.format(cadEuler.y) +
    "*C" + abcFormat.format(cadEuler.z) +
    "*X" + xyzFormat.format(-cadOrigin.x) +
    "*Y" + xyzFormat.format(-cadOrigin.y) +
    "*Z" + xyzFormat.format(-cadOrigin.z) +
    "]"
  );
}

function inspectionWriteWorkplaneTransform() {
  var orientation = (machineConfiguration.isMultiAxisConfiguration() && currentMachineABC != undefined) ? machineConfiguration.getOrientation(currentMachineABC) : currentSection.workPlane;
  var abc = orientation.getEuler2(EULER_XYZ_S);
  writeln("DPRNT[G330" +
    "*N" + getPointNumber() +
    "*A" + abcFormat.format(abc.x) +
    "*B" + abcFormat.format(abc.y) +
    "*C" + abcFormat.format(abc.z) +
    "*X0*Y0*Z0*I0*R0]"
  );
}

function writeProbingToolpathInformation(cycleDepth) {
  writeln("DPRNT[TOOLPATHID*" + getParameter("autodeskcam:operation-id") + "]");
  if (isInspectionOperation()) {
    writeln("DPRNT[TOOLPATH*" + getParameter("operation-comment") + "]");
  } else {
    writeln("DPRNT[CYCLEDEPTH*" + xyzFormat.format(cycleDepth) + "]");
  }
}

function onClose() {
  if (isDPRNTopen) {
    writeln("DPRNT[END]");
    writeBlock("PCLOS");
    isDPRNTopen = false;
    if (typeof inspectionProcessSectionEnd == "function") {
      inspectionProcessSectionEnd();
    }
  }

  if (probeVariables.probeAngleMethod == "G68") {
    cancelWorkPlane();
  }
  writeln("");
  optionalSection = false;

  setCoolant(COOLANT_OFF);
  if (tool.type != TOOL_PROBE && (getProperty("washdownCoolant") == "always" || getProperty("washdownCoolant") == "programEnd")) {
    if (getProperty("washdownCoolant") == "programEnd") {
      writeBlock(mFormat.format(washdownCoolant.on));
    }
    writeBlock(mFormat.format(washdownCoolant.off));
  }

  writeBlock(mTurningModal.format(141));

  // reload first tool (handles retract)
  writeBlock(gFormat.format(100), "T" + toolFormat.format(getSection(0).getTool().number));
  if (useMultiAxisFeatures) {
    writeRetract(Z);
  } else {
    retracted = true; // tool call does a full retract along the z-axis
  }
  writeRetract(X, Y);
  setSmoothing(false);

  if (useMultiAxisFeatures) {
    writeBlock(gFormat.format(49));
    forceWorkPlane();
  }
  setWorkPlane(new Vector(0, 0, 0)); // reset working plane

  if (useMultiAxisFeatures) {
    writeBlock(
      gAbsIncModal.format(91), gFormat.format(28),
      conditional(machineConfiguration.isMachineCoordinate(0), "A" + abcFormat.format(0)),
      conditional(machineConfiguration.isMachineCoordinate(1), "B" + abcFormat.format(0)),
      conditional(machineConfiguration.isMachineCoordinate(2), "C" + abcFormat.format(0))
    );
  }
  onImpliedCommand(COMMAND_END);
  onImpliedCommand(COMMAND_STOP_SPINDLE);
  writeBlock(mFormat.format(30)); // stop program, spindle stop, coolant off
}

function setProperty(property, value) {
  properties[property].current = value;
}
