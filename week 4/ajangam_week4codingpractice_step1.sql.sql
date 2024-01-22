/* MATH */

SELECT 2 + 2;
SELECT 9 - 1;
SELECT 3 * 4;


SELECT 11  / 6;
-- To remove the fractional point, you need to use the DIV operator as follows:
SELECT 11 DIV 6;
SELECT 11 % 6;
SELECT 11.0 / 6;
SELECT CAST(11 AS decimal(3,1)) / 6;


/* Expopnents, Roots, Fatorials */

SELECT POW(3,4);
SELECT sqrt(10);

-- For factorial create a function (select create function and run the entire function until END:
delimiter // -- default delimiteer is semi-column, we are changing it for function
-- In mathematics, the factorial of a non-negative integer n, denoted by n!, is the product of all positive integers less than or equal to n. For example,-- n! = n·(n-1)·(n-2)·(n-3)·...·3·2·1
-- n is the name of the variable that will take place on the basis of calculation of the factorial
-- source: https://gist.github.com/enflo/5ad73828d7d24c2bf45d
CREATE FUNCTION factorial(n INT)
RETURNS INT(11)
BEGIN
DECLARE factorial INT;
SET factorial = n ;
IF n <= 0 THEN
RETURN 1;
END IF;

bucle: LOOP
SET n = n - 1 ;
IF n<1 THEN
LEAVE bucle;
END IF;
SET factorial = factorial * n ;
END LOOP bucle;
RETURN factorial;
END//

delimiter ;


SELECT factorial(3); -- 3!
SELECT factorial(8); -- 8!


SELECT 7 + 8 * 9;
SELECT (7 + 8) * 9;