package cz.zk.rtpreceiver;

import org.kurento.client.KurentoClient;

import org.kurento.client.MediaPipeline;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

@SpringBootApplication
@EnableWebSocket
public class RtpReceiverApplication  implements WebSocketConfigurer {

	@Value("${kms.host}")
	private String kmsHost;

	@Bean
	public Handler handler()
	{
		return new Handler();
	}

	@Bean
	public KurentoClient kurentoClient()
	{
		//KurentoClient client = KurentoClient.create("ws://" + kmsHost + "/kurento");
		//MediaPipeline mediaPipeline = client.createMediaPipeline();
		//mediaPipeline.setLatencyStats(true);

		//return client;
		return KurentoClient.create("ws://" + kmsHost + "/kurento");
	}

	@Bean
	public ServletServerContainerFactoryBean createServletServerContainerFactoryBean() {
		ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
		container.setMaxTextMessageBufferSize(32768);
		return container;
	}


	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry)
	{
		registry.addHandler(handler(), "/rtpreceiver");
	}


	public static void main(String[] args) {
		SpringApplication.run(RtpReceiverApplication.class, args);
	}

}
