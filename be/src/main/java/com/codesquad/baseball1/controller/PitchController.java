package com.codesquad.baseball1.controller;

import com.codesquad.baseball1.dao.InningDao;
import com.codesquad.baseball1.dao.LogDao;
import com.codesquad.baseball1.dao.RecordDao;
import com.codesquad.baseball1.domain.HalfInning;
import com.codesquad.baseball1.domain.Record;
import com.codesquad.baseball1.dto.ResponseDto;
import com.codesquad.baseball1.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import javax.sql.DataSource;
import java.util.*;

@RestController
public class PitchController {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private LogDao logDao;
    @Autowired
    private RecordDao recordDao;
    @Autowired
    private InningDao inningDao;
    @Autowired
    private LogService logService;

    public PitchController(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }


    @GetMapping("/matches/{matchId}/pitch")
    public ResponseDto pitch(@PathVariable int matchId) {
        Map matches = logService.figureHomeOrAway(matchId);
        int homeId = (int) matches.get("home");
        int awayId = (int) matches.get("away");
        HalfInning thisInning = inningDao.findHalfInningToPlay();
        int inningId = thisInning.getInningId();
        if (inningId%2 != 0 && !inningDao.isThreeOut(thisInning)) {
            return logService.makePitch(inningId, homeId);
        } else if (inningId%2 == 0 && !inningDao.isThreeOut(thisInning)) {
            return logService.makePitch(inningId, awayId);
        }
        return null;
    }

    @GetMapping("/matches/{matchId}/getPitch")
    public ResponseDto getPitch(@PathVariable int matchId) {
        HalfInning thisInning = inningDao.findHalfInningToPlay();
        int inningId = thisInning.getInningId();
        return new ResponseDto(200, inningDao.findInningById(inningId));
    }

}