/* Get maximum amount of active sessions */

/* http://sqlfiddle.com/#!9/6dce75/1 */

--------------------------------------------------------------------

SET @CNT:=0;
SET @INC:=1;
SET @DEC:=-1;

SELECT `AMOUNT` FROM 
(
	SELECT *, @CNT:=@CNT+CNT AS AMOUNT FROM
	(
		SELECT `Left` as `Date`, @INC AS CNT FROM `session`
		UNION
		SELECT `Right` as `Date`, @DEC AS CNT FROM `session`
	) T1
	ORDER BY `Date`
) T2
ORDER BY `AMOUNT` DESC LIMIT 1

--------------------------------------------------------------------

CREATE TABLE `session` (
  `id` int(6) UNSIGNED NOT NULL,
  `Left` date NOT NULL,
  `Right` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `session` (`id`, `Left`, `Right`) VALUES
(1, '2010-10-10', '2010-10-20'),
(2, '2010-10-15', '2010-10-25'),
(3, '2010-10-05', '2010-10-15'),
(4, '2010-10-17', '2010-10-28'),
(5, '2015-10-10', '2016-10-10'),
(6, '2017-10-10', '2018-10-10'),
(7, '2010-10-07', '2010-10-08'),
(8, '2010-10-06', '2010-10-07');

ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);
COMMIT;