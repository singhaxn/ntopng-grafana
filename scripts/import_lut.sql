CREATE TABLE asn4_import
(
    ip_start TEXT,
    ip_end TEXT,
    asn INTEGER,
    org TEXT
);
.import --csv asn-ipv4.csv asn4_import

CREATE TABLE asn4
(
    asn INTEGER PRIMARY KEY,
    org TEXT
);
INSERT INTO asn4 SELECT DISTINCT asn, org FROM asn4_import;
DROP TABLE asn4_import;

SELECT * FROM asn4 LIMIT 10;

CREATE TABLE oui
(
    registry TEXT,          -- Registry
    assignment VARCHAR(6),  -- Assignment
    org TEXT,               -- Organization Name
    addr TEXT               -- Organization Address
);
.import --skip 1 --csv oui.csv oui
ALTER TABLE oui ADD oui VARCHAR(8);
UPDATE oui SET oui = substr(assignment, 1,2) || ":" || substr(assignment,3,2) || ":" || substr(assignment,5,2);
CREATE INDEX oui_idx ON oui(oui);

SELECT * FROM oui LIMIT 10;
