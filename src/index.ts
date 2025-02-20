import smtp from "smtp-server";
const SMTPServer = smtp.SMTPServer;

const server = new SMTPServer({
  allowInsecureAuth: true,
  authOptional: true,

  onConnect(session, callback): void {
    console.log("onConnect", session);
    callback();
  },
  onMailFrom(address, session, callback): void {
    console.log("onMailFrom", address, session);
    callback();
  },
  onRcptTo(address, session, callback): void {
    console.log("onRcptTo", address, session);
    callback();
  },
  onData(stream, session, callback): void {
    stream.on("data", (data) => {
      console.log("onData", data.toString());
    });
    stream.on("end", () => {
      console.log("onData end");
      callback();
    });
  },
});

server.listen(25, () => console.log("Server is running on port 25"));
