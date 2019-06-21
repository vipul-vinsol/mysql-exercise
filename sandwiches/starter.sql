CREATE TABLE tastes ( name varchar(50), filling varchar(50) );

INSERT INTO tastes VALUES ( 'Brown', 'Turkey' );
INSERT INTO tastes VALUES ( 'Brown', 'Beef' );
INSERT INTO tastes VALUES ( 'Brown', 'Ham' );
INSERT INTO tastes VALUES ( 'Jones', 'Cheese' );
INSERT INTO tastes VALUES ( 'Green', 'Beef' );
INSERT INTO tastes VALUES ( 'Green', 'Turkey' );
INSERT INTO tastes VALUES ( 'Green', 'Cheese' );


CREATE TABLE sandwiches ( location varchar(100), bread varchar(50), filling varchar(50), price DECIMAL );
INSERT INTO sandwiches VALUES ( 'Lincoln', 'Rye', 'Ham', 1.25 );
INSERT INTO sandwiches VALUES ( "O'Neill's", 'White', 'Cheese', 1.20 );
INSERT INTO sandwiches VALUES ( "O'Neill's", 'Whole', 'Ham', 1.25 );
INSERT INTO sandwiches VALUES ( 'Old Nag', 'Rey', 'Beef', 1.35 );
INSERT INTO sandwiches VALUES ( 'Buttery', 'White', 'Cheese', 1.00 );
INSERT INTO sandwiches VALUES ( "O'Neill's", 'White', 'Turkey', 1.35 );
INSERT INTO sandwiches VALUES ( 'Buttery', 'White', 'Ham', 1.10 );
INSERT INTO sandwiches VALUES ( 'Lincoln', 'Rey', 'Beef', 1.35 );
INSERT INTO sandwiches VALUES ( 'Lincoln', 'White', 'Ham', 1.30 );
INSERT INTO sandwiches VALUES ( 'Old Nag', 'Rey', 'Ham', 1.40 );


CREATE TABLE locations ( l_name varchar(100), phone varchar(10), address varchar(100) );
INSERT INTO locations VALUES ( 'Lincoln', '683 4523', 'Lincoln Place' );
INSERT INTO locations VALUES ( "O'Neill's", '674 2134', 'Pearse St' );
INSERT INTO locations VALUES ( 'Buttery', '702 3421', 'College St' );
INSERT INTO locations VALUES ( 'Old Nag', '767 8132', 'Dame St' );
