ALTER TABLE refs_biological.FATES ADD COLUMN code_orig CHAR(3);
UPDATE refs_biological.FATES SET code_orig ='DDL' WHERE code ='DL' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DDM' WHERE code ='DM' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DDS' WHERE code ='DS' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DFL' WHERE code ='FL' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DFR' WHERE code ='FR' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DPQ' WHERE code ='PQ' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DRB' WHERE code ='RB' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DTR' WHERE code ='TR' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DTS' WHERE code ='TS' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DUD' WHERE code ='UD' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DUN' WHERE code ='UN' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='DUS' WHERE code ='US' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='ESC' WHERE code ='ES' AND type_of_fate_code='DI';
UPDATE refs_biological.FATES SET code_orig ='RCC' WHERE code ='CC' AND type_of_fate_code='RE';
UPDATE refs_biological.FATES SET code_orig ='RET' WHERE code ='UN' AND type_of_fate_code='RE';
UPDATE refs_biological.FATES SET code_orig ='RFB' WHERE code ='FB' AND type_of_fate_code='RE';
UPDATE refs_biological.FATES SET code_orig ='RFL' WHERE code ='FL' AND type_of_fate_code='RE';
UPDATE refs_biological.FATES SET code_orig ='RFR' WHERE code ='FR' AND type_of_fate_code='RE';
-- UPDATE refs_biological.FATES SET code_orig ='RFT' WHERE code ='UN' AND type_of_fate_code='RE';
UPDATE refs_biological.FATES SET code_orig ='UNK' WHERE code ='UN' AND type_of_fate_code='RE';
ALTER TABLE refs_biological.FATES ALTER COLUMN code_orig SET NOT NULL;

ALTER TABLE refs_fishery.fish_preservation_methods ADD COLUMN code_orig CHAR(3);
UPDATE refs_fishery.fish_preservation_methods SET code_orig = code;
UPDATE refs_fishery.fish_preservation_methods SET code_orig = 'CWS' WHERE code = 'CW' ;
ALTER TABLE refs_fishery.fish_preservation_methods ALTER COLUMN code_orig SET NOT NULL;

ALTER TABLE refs_biological.measurements ADD COLUMN code_orig CHAR(3);
UPDATE refs_biological.measurements SET code_orig = code;
UPDATE refs_biological.measurements SET code_orig = 'TW' WHERE code = 'DW' ;
ALTER TABLE refs_biological.measurements ALTER COLUMN code_orig SET NOT NULL;

ALTER TABLE refs_biological.sex ADD COLUMN code_orig CHAR(3);
UPDATE refs_biological.sex SET code_orig = code WHERE code != 'U';
UPDATE refs_biological.sex SET code_orig = 'I' WHERE code = 'N';
UPDATE refs_biological.sex SET code_orig = 'UNK' WHERE code = 'U';
ALTER TABLE refs_biological.sex ALTER COLUMN code_orig SET NOT NULL;
INSERT INTO refs_biological.sex ( code, code_orig, name_en, name_fr, is_determined) VALUES ('J', 'J', 'Juvenile', 'Juvénile', 0);

ALTER TABLE ros_ll.ll_catch_details ADD COLUMN  type_of_fate_code CHAR(2);
ALTER TABLE ros_gn.gn_catch_details ADD COLUMN  type_of_fate_code CHAR(2);
ALTER TABLE ros_ps.ps_catch_details ADD COLUMN  type_of_fate_code CHAR(2);
ALTER TABLE ros_pl.pl_catch_details ADD COLUMN  type_of_fate_code CHAR(2);
ALTER TABLE ros_common.measured_lengths ADD COLUMN  type_of_measurement_code CHAR(2);
ALTER TABLE ros_common.estimated_weights ADD COLUMN  type_of_measurement_code CHAR(2);
