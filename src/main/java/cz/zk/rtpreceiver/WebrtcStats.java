package cz.zk.rtpreceiver;

import lombok.Data;

@Data
public class WebrtcStats {

    private String  SessionId;
    private String ssrc;
    private long RTPPacketsReceived;
    private long RTPBytesReceived;
    private String WEBStatus;
    private long WEBPacketsSent;
    private long WEBBytesSent;

}
