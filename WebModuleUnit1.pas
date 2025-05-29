unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, System.DateUtils;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1ActHealthAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule1.WebModule1ActHealthAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  HealthData: string;
begin
  Response.ContentType := 'application/json';
  HealthData := Format('''
    {
      "status": "healthy",
      "timestamp": "%s",
      "uptime": "%s",
      "version": "1.0.0",
      "environment": "%s",
      "container": %s
    }
  ''', [
    FormatDateTime('yyyy-mm-dd"T"hh:nn:ss.zzz"Z"', TTimeZone.Local.ToUniversalTime(Now)),
    TimeToStr(Now),
    {$IFDEF LINUX}'Linux'{$ELSE}'Windows'{$ENDIF},
    {$IFDEF CONTAINER}'true'{$ELSE}'false'{$ENDIF}
  ]);
  
  Response.Content := HealthData;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Delphi Summit 2025</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
      <style>
        .container {
          max-width: 800px;
          margin: 0 auto;
          padding: 2rem;
          text-align: center;
        }
        .logo {
          max-width: 100%;
          height: auto;
          margin: 2rem 0;
        }
        .footer {
          margin-top: 3rem;
          font-size: 0.9rem;
          color: var(--muted-color);
        }
        .footer a {
          color: var(--primary);
          text-decoration: none;
        }
        .footer a:hover {
          text-decoration: underline;
        }
      </style>
    </head>
    <body>
      <main class="container">
        <h1>Welcome to Delphi Summit 2025</h1>
        <img src="https://media-01.imu.nl/storage/delphisummit.com/28054/delphi-summit-2025.png" 
             alt="Delphi Summit 2025" 
             class="logo">
        <p>Join us for the most exciting Delphi conference of the year!</p>
        <footer class="footer">
          <p>Powered by Delphi WebBroker | <a href="/health" target="_blank">Check Health Status</a></p>
        </footer>
      </main>
    </body>
    </html>
  ''';
end;

end.
