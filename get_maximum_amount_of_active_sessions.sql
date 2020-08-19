/* Get maximum amount of active sessions */

/* http://sqlfiddle.com/#!9/6dce75/1 */

--------------------------------------------------------------------

SET @login_time = '2015-10-10';
SET @login_time = '2027-20-20';
SET @cnt:=0;
SET @inc:=1;
SET @dec:=-1;

SELECT `amount` FROM 
(
    SELECT *, @cnt:=@cnt+cnt AS amount FROM
    (
        SELECT `login_time` as `time`, @inc AS cnt FROM `session` WHERE `login_time` >= @login_time 
        UNION
        SELECT `logout_time` as `time`, @dec AS cnt FROM `session`  WHERE `login_time` >= @login_time AND `logout_time` <= @logout_time
    ) T1
    ORDER BY `time`
) T2
ORDER BY `amount` DESC LIMIT 1

--------------------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(6) UNSIGNED NOT NULL,
  `login_time` datetime NOT NULL,
  `logout_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `login_time`, `logout_time`) VALUES
(1, '2010-10-10 00:00:00', '2010-10-20 00:00:00'),
(2, '2010-10-15 00:00:00', '2010-10-25 00:00:00'),
(3, '2010-10-05 00:00:00', '2010-10-15 00:00:00'),
(4, '2010-10-17 00:00:00', '2010-10-28 00:00:00'),
(5, '2015-10-10 00:00:00', '2016-10-10 00:00:00'),
(6, '2017-10-10 00:00:00', '2018-10-10 00:00:00'),
(7, '2010-10-07 00:00:00', '2010-10-08 00:00:00'),
(8, '2010-10-06 00:00:00', '2010-10-07 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;
