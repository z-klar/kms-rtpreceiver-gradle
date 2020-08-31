package cz.zk.rtpreceiver;

import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
public class StatsController {

    @Autowired
    private Handler handler;

    // GET /rtr-relay/outputs
    @RequestMapping(value = "/webrtc/statistics")
    public ResponseEntity<Object> getOutputs() {
        Gson gson = new Gson();
        ArrayList<WebrtcStats> stats = handler.GetStats();
        String spom = gson.toJson(stats);
        return new ResponseEntity<>(spom, HttpStatus.OK);
    }
}
