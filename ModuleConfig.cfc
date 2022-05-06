component {

    function configure() {
        variables.fileSystem = wirebox.getInstance( 'fileSystem' );
        variables.shell = wirebox.getInstance( 'shell' );
    }

    // Before any model is autowired in WireBox
    function beforeInstanceAutowire( interceptData ) {
        var mapping = interceptData.mapping;

        // If the instance is a Task Runner
        if( mapping.isVirtualInheritance() && mapping.getVirtualInheritance() == 'commandbox.system.BaseTask' ) { 
            
            // Loop over the proeprty injectins
            mapping.getDIProperties().each( (prop)=>{
                // If the injection has a DSL without a `:`...
                if( !isNull( prop.dsl ) && !prop.dsl.find( ':' ) ) {
                    var CFCPath = shell.pwd() & prop.dsl & '.cfc';
                    // ... check and see if it points to a CFC in the working dir of the shell
                    if( fileExists( CFCPath ) ) {
                        // and override it to be a full relative path to taht CFC
                        var CFCInvocationPath = fileSystem.makePathRelative( shell.pwd() & prop.dsl ).listChangeDelims( '.', '/\' );
                        prop.dsl = CFCInvocationPath;
                    }
                    
                }	
            } );
            
        }
    }

}